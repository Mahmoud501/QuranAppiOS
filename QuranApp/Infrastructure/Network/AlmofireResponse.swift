//
//  ResponseModel.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation

class AlmofireResponse {
    
    private var loadingCallback: ((_ response:Double?) -> Void)?
    private var callback : ((_ result: Result<Data,Error>?) -> Void)?

    
    var result: Result<Data,Error>? {
        didSet {
            self.callback?(result)
        }
    }
    
    var loading: Double? {
        didSet {
            self.loadingCallback?(loading)
        }
    }
    
    func report(_ callback: @escaping (Result<Data,Error>?) -> Void) {
        self.callback = callback
    }
    
    func reportLoading(_ loadingCallback: @escaping ((_ response:Double?) -> Void)) {
        self.loadingCallback = loadingCallback
    }

}
