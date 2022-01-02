//
//  NetworkMiddleware.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire


class NetworkAdministration {
    
    private var requests: [String: Request]?
    private var networkHandler: NetworkHandler?
    init(requests: [String: Request]? = nil, networkHandler: NetworkHandler? = nil) {
        self.networkHandler = networkHandler ?? NetworkHandler(delegate: self)
        self.requests = requests
    }
    
    lazy private var sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    
    func request<T>(request: AlmofireRequest<T>, debug: Bool) -> AlmofireResponse? {
       return networkHandler?.request(request.asURLRequest(), debug: debug)
    }
    
    func upload<T>(files: [File], request: AlmofireRequest<T>, debug: Bool) -> AlmofireResponse? {
        return networkHandler?.upload(files: files, to: request.asURLRequest(), debug: debug)
    }
    
    func download<T>(file: File, request: AlmofireRequest<T>, debug: Bool) -> AlmofireResponse? {
        return networkHandler?.download(file: file, url: request.asURLRequest(), debug: debug)
    }
    
    private func appendRequest(indentifier: String, request: Request) {
        if self.requests == nil {
            self.requests = [String: Request]()
        }
        self.requests?[indentifier] = request
    }
    
    func cancelRequest(request: Request) {
        request.cancel()
    }
    
    func cancelRequest(indentifier: String) {
        requests?[indentifier]?.cancel()
        self.requests?.removeValue(forKey: indentifier)
    }
    
    func cancelAllRequests() {
        if let indentifiers = requests?.keys {
            for indentifier in indentifiers {
                requests?[indentifier]?.cancel()
            }
            requests = nil
        }
    }
}

extension NetworkAdministration: NetworkHandlerDelegate {
    
    func didAddRequest(request: Request) {
        let url = request.request?.url
        if let path = url?.relativePath, let schema = url?.scheme ,let host = url?.host {
            let id = schema + "://" + host + path
            appendRequest(indentifier: id, request: request)
        }
    }
}
