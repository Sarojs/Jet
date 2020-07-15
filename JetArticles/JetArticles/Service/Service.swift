//
//  Service.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/11/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation


/// Set of service endpoints to connect
enum EndPoint: String {
    case articles = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/blogs?"
    case userDetails = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/users?"
}

enum RequestStatus {
    case inProgress
    case completed
    case failed
}

/// Possible result statuses
enum ServiceResult<T> {
    case success(T)
    case failed
}

protocol Service {
    
    /// Type of response that this service class will pass on completion
    associatedtype ResponseType
    typealias Callback = (ServiceResult<ResponseType>) -> Void
    
    /// Execute the service to given endpoint, `completion` will be invoked with resulting data/response/error.
    func execute(completion: @escaping Callback)
}
