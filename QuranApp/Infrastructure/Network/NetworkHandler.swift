//
//  NetworkHandler.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkHandlerProtocol {
    
    func request(request: URLRequest)
    
}

protocol NetworkHandlerDelegate : class{
    func didAddRequest(request: Request)
}


class NetworkHandler {
    
    private var manager: SessionManager?
    private weak var delegate: NetworkHandlerDelegate?
    init(manager: SessionManager? = nil, delegate: NetworkHandlerDelegate?) {
        self.manager = manager ?? Alamofire.SessionManager()
        self.delegate = delegate
    }
    
    
    
    
    func request(_ request: URLRequest, debug: Bool = false) -> AlmofireResponse {
        let FutureResult = AlmofireResponse()
        
        let request = manager?.request(request).validate().responseJSON { response in

            self.verifyResponseData(FutureResult: FutureResult, debug: debug, response: response)
            
        }
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    

    
    func upload(files: [File]?, to request: URLRequest, debug: Bool = false) -> AlmofireResponse {
        
        let FutureResult = AlmofireResponse()
        
        manager?.upload(multipartFormData: { (formData) in
            
            if let files = files {
                files.forEach { file in
                    formData.append(file.data, withName: file.key, fileName: file.name, mimeType: file.mimeType.rawValue)
                }
            }
            
            
        }, usingThreshold: UInt64.init(), with: request, queue: nil, encodingCompletion: { encodingResult in
            
                switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (Progress) in
                            
                            FutureResult.loading = Progress.fractionCompleted
                            
                        })
                        let request = upload.responseJSON { response in
                            self.verifyResponseData(FutureResult: FutureResult, debug: debug, response: response)
                        }

                        self.delegate?.didAddRequest(request: request)
                    
                        case .failure(let encodingError):
                            FutureResult.result = .failure(encodingError)
                            break
                        }
        })
    

        
        return FutureResult
       }
    
    
    
    func download(file: File, url: URLRequest, debug: Bool) -> AlmofireResponse {
        
        let FutureResult = AlmofireResponse()
         
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let extensionFile = file.mimeType.getFileExtension()
            documentsURL.appendPathComponent(file.name + "." + extensionFile)
            return (documentsURL, [.removePreviousFile])
        }

        let request = manager?.download( url.url!.absoluteString,
        method: .get,
        encoding: JSONEncoding.default,
        headers: nil,
        to: destination).downloadProgress(closure: { (progress) in

            FutureResult.loading = progress.fractionCompleted

        }).response(completionHandler: { response in

            if debug { if response.resumeData != nil { print(response.resumeData!.convertToJson() as Any) } }
                       
            if response.error != nil {
                let error = response.error ?? NetworkError.unknownError("Unknown")
                FutureResult.result = .failure(error)
                if debug { print(error.localizedDescription) }

            }else {
                FutureResult.result = .success(response.resumeData ?? Data())
            }
        })
       
        if request != nil { delegate?.didAddRequest(request: request!) }
        return FutureResult
    }
    
    
    
    
    
}

extension NetworkHandler {

    private func verifyError(response: DataResponse<Any>) -> NetworkError? {
            
            // these for this app only remove it if required
        
            if let Error  = customError(data: response.data) {
                return Error
            }
        
           if let _ = response.error, (response.error as NSError?)?.code == -999 {
               return .cancelled
           }

           if let _ = response.error, (response.error as NSError?)?.code == -1009 {
               return .noInternetConnection
           }

           guard let _ = response.data else {
               return .invalidData
           }

           if let response = response.response, case 500...511 = response.statusCode {
               return .internalServerError
           }

           if let response = response.response, response.statusCode == 401 {
               return .unauthorized
           }
           
           //Handle the errors generally from the API according to their defined structure
           if response.response?.statusCode == 200 {
               guard let jsonObject = try? JSONSerialization.jsonObject(with: response.data ?? Data(), options: []) as? [String: AnyObject] else { return .internalServerError }
                if let success = jsonObject["error"] as? [String: Any] {
                   if let message = jsonObject["error"]?["message"] as? String {
                       return .unknownError(message)
                   } else {
                       return .internalServerError
                   }
               }
           }

           return nil
       }
    
    private func extractPaginationData(from response: DataResponse<Any>) -> NetworkError? {
        guard let _ = response.response?.allHeaderFields as? [String: String] else {
            return .internalServerError
        }

        return nil
    }
    
    private func customError(data: Data?) -> NetworkError? {
        
        if let result = data {
            let dictResult = result.convertToJson() //convert to dict
            if let status = dictResult?["error"] as? [String: Any] {
                    var err = ""
                let messages = status["errors"] as? [String:Any]
                var errors = ""
                if(messages != nil) {
                    for (_, value) in messages! {
                        let arr = value as? Array<Any>
                        for err in arr ?? [] {
                            errors = errors + ((err as? String) ?? "") + "\n"
                        }
                    }
                    err = errors
                }
                if err == "" {
                    let message = status["message"] as? String
                    err = message ?? ""

                }

                return .unknownError(err)
            }
        }
        
        return nil
    }
    
    private func verifyResponseData(FutureResult: AlmofireResponse, debug: Bool, response: DataResponse<Any>) {
        
        if debug { if response.data != nil { print(response.data!.convertToJson() as Any) } }
                   
                   if let error = self.verifyError(response: response) {
                       FutureResult.result = .failure(error)
                       if debug { print(error.localizedDescription) }
                       return
                   }

                   if let error = self.extractPaginationData(from: response) {
                       FutureResult.result = .failure(error)
                       if debug { print(error.localizedDescription) }
                       return
                   }
                   if response.data != nil {
                       FutureResult.result = .success(response.data!)
                   }else {
                       let error = response.error ?? NetworkError.unknownError("Unknown")
                       FutureResult.result = .failure(error)
                       if debug { print(error.localizedDescription) }
                   }
    }
    
    
    
}
