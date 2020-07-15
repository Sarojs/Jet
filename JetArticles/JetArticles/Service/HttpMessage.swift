//
//  HttpMessage.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/11/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation


/// A raw structure for HTTP requests
struct HttpMessage {
    
    typealias Parameter = [AnyHashable: Any]
    typealias Completion = (Data?, URLResponse?, Error?) -> Void
    
    func execute(imageURL: String, parameters: Parameter? = nil, completion: Completion?) {
        
        guard let url = URL(string: imageURL) else {
            fatalError("Url string couldn't be converted to valid URL type, \(imageURL)")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: url) { (data, urlResponse, error) in
            
            debugPrint(String(data: data!, encoding: .utf8) ?? "")
            
            DispatchQueue.main.async(execute: {
                completion?(data, urlResponse, error)
            })
            
        }.resume()
    }
}
