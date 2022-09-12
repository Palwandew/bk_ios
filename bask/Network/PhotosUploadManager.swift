//
//  PhotoUploadManager.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 23/08/2022.
//

import Foundation
import Combine


class PhotosUploadManager: NSObject {
    
    typealias Percentage = Double
    typealias ProgressHandler = (Percentage) -> Void
    typealias CompletionHandler = (Result<String, Error>) -> Void
    
    
    private typealias Subject = CurrentValueSubject<Percentage, Error>
    
    private let configuration = URLSessionConfiguration.background(withIdentifier: "baskuploading")
    private lazy var urlSession = URLSession(
        configuration: configuration,
        delegate: self,
        delegateQueue: nil
    )
    
    private var progressHandlersByTaskID = [Int : ProgressHandler]()
    private var completionHadlerByTask = [Int : CompletionHandler]()
    
    //private var subjectsByTaskID = [Int : Subject]()
    
    func uploadFile(from pathURL: URL,
                    to targetURL: URL,
                    progressHandler: @escaping ProgressHandler,
                    completionHandler: @escaping CompletionHandler) {

        
        var request = URLRequest(
            url: targetURL,
            cachePolicy: .reloadIgnoringLocalCacheData
        )
        
        request.httpMethod = "PUT"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.uploadTask(
            with: request,
            fromFile: pathURL)
        
        progressHandlersByTaskID[task.taskIdentifier] = progressHandler
        completionHadlerByTask[task.taskIdentifier] = completionHandler
        task.resume()
    }
    
    
    
    func finishUploadingTasksAndInvalidate(){
        urlSession.finishTasksAndInvalidate()
    }
    
}

extension PhotosUploadManager: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        let completion = completionHadlerByTask[task.taskIdentifier]
        
        if let error = error {
            print("error")
            completion?(.failure(error))
        }
        
        if let response = task.response as? HTTPURLResponse {
            if response.statusCode == 200 {
                print("added +++")
                completion?(.success("Picture uploaded"))
            }
        }
    }
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64
    ) {
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        let handler = progressHandlersByTaskID[task.taskIdentifier]
        handler?(progress)
    }
    
    
}


enum UploadResponse {
    case progress(percentage: Double)
    case response(data: Data?)
}


enum UploadError: Error {
    case urlError
}
