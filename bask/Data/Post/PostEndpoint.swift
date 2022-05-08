//
//  PostEndpoint.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 08/05/2022.
//

import Foundation

struct PostEndpoint: Endpoint{
    var path: String
    
    var method: RequestMethod
    
    var header: [String : String]?
    
    var body: [String : String]?
    
    init(path: String, mehtod: RequestMethod){
        self.path = path
        self.method = mehtod
        self.header = nil
        self.body = nil
    }
}
