//
//  LoginEndpoint.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

struct LoginEndpoint: Endpoint{
    var path: String
    
    var method: RequestMethod
    
    var header: [String : String]?
    
    var body: [String : String]?
    
    init(path: String, method: RequestMethod, header: [String: String], body: [String: String]){
        self.path = path
        self.method = RequestMethod.post
        self.header = header
        self.body = body
    }
}
