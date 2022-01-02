//
//  APIRequest.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire


class AlmofireRequest<T: Encodable> {
   
    private var value: T
    var method: HttpMethod!
    var path: String!
    var sendInBody: Bool?
    var header: [String: Any]?

    init(method: HttpMethod = .get, path: String = "", header: [String: Any]? = nil, value: T) {
        self.method = method
        self.path = path
        self.header = header
        self.value = value
    }
    
    func asURLRequest() -> URLRequest {
        let urlpatharabic = path.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        
        let url : URL = URL.init(string: urlpatharabic!) ?? URL(fileURLWithPath: "")
        var urlRequest = URLRequest(url: url)
        urlRequest = appendHeader(header: header, to: urlRequest)
        urlRequest.httpMethod = getHttpMehod(value: method)
        if sendInBody == true {
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(value)
            if jsonData != nil {
                let json = String(data: jsonData!, encoding: String.Encoding.utf8)
                let data =  json?.data(using: .utf8)
                urlRequest.httpBody = data ?? Data()
            }
        }else {
            urlRequest.url = getQueryItems(model: value)
        }

        return urlRequest
    }
    
    
}

extension AlmofireRequest {
    
   private func appendHeader(header: [String: Any]?, to: URLRequest) -> URLRequest {
        var urlRequest = to
        if header != nil{
            for item in header!.keys{
                urlRequest.addValue(header![item] as! String, forHTTPHeaderField: item)
            }
        }
        return urlRequest
    }
    
    private func getHttpMehod(value: HttpMethod) -> HTTPMethod.RawValue
     {
            switch value {
            case .get:
                return HTTPMethod.get.rawValue
            case .post:
                return HTTPMethod.post.rawValue
            case .delete:
                return HTTPMethod.delete.rawValue
            case .patch:
                return HTTPMethod.patch.rawValue
            case .put:
                return HTTPMethod.put.rawValue
            default:
                return HTTPMethod.get.rawValue
            }
      }
    
    private func getQueryItems<T>(model: T) -> URL {
         var url = URL(string: path)!
        let mirror = Mirror(reflecting: model)
          for child in mirror.children  {
            let name = child.label!
            let value = child.value as? [String]
            if value != nil {
                for item in value!{
                    let value = item.replacedArabicDigitsWithEnglish
                    if value != "" {
                        url = url.appending(name + "[]", value: value)
                    }
                }
            }else {
                let val = child.value as? String
                let value = val?.replacedArabicDigitsWithEnglish
                if (value ?? "") != "" {
                    url = url.appending(name, value: value)
                }
              }
          }
          return url
      }
}

