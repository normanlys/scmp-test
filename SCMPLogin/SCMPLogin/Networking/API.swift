//
//  API.swift
//  SCMPLogin
//
//  Created by Norman Lim on 3/12/2018.
//  Copyright © 2018 Norman Lim. All rights reserved.
//

import Foundation

class API {
    func login(_ email: String, _ password: String) -> String? {
        let delay = 3
        let json = "{'email': \(email), 'password': \(password)}"
        let url = URL(string: "https://reqres.in/api/login?delay=\(delay)")!
        
        var token: String? = nil
        _ = post(url: url, jsonString: json) {
            (responseString, errorString) in
            if errorString != nil {
                token = responseString!
            } else {
                token = nil
            }
        }
        
        return token
    }
    
    private func post(url: URL, jsonString: String, handler: @escaping (_ responseString: String?, _ errorString: String?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.httpBody = jsonString.data(using: .utf8)
        
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            guard let data = data else {
                handler(nil, "No data")
                return
            }
            guard let postResponse = String(data: data, encoding: .utf8) else {
                handler(nil, "Cannot be decoded")
                return
            }
            handler(postResponse, nil)
        }
        task.resume()
    }
}
