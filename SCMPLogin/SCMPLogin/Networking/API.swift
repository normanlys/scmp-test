//
//  API.swift
//  SCMPLogin
//
//  Created by Norman Lim on 3/12/2018.
//  Copyright © 2018 Norman Lim. All rights reserved.
//

import Foundation

class API {
    func login(_ email: String, _ password: String) -> String {
        let delay = 3
        let json = "{'email': \(email), 'password': \(password)}"
        let url = URL(string: "https://reqres.in/api/login?delay=\(delay)")!
        
        var token = "test"
        _ = post(url: url, jsonString: json) {postResponse in
            sleep(UInt32(delay))
            token = postResponse
        }
        
        return token
    }
    
    private func post(url: URL, jsonString: String, handler: @escaping (_ postResponse: String) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.httpBody = jsonString.data(using: .utf8)
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                if let postResponse = String(data: data, encoding: .utf8) {
                    handler(postResponse)
                }
            }
        }
        task.resume()
    }
    
//    private func post(url: URL, body: Data, completionHandler: @escaping (String) -> Void = {_ in return}) -> URLSessionTask {
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = body
//
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: request) {
//            (data, response, error) in
//            if let data = data {
//                if let postResponse = String(data: data, encoding: .utf8) {
//                    completionHandler(postResponse)
//                }
//            }
//        }
//
//        task.resume()
//
//        return task
//    }
    
}
