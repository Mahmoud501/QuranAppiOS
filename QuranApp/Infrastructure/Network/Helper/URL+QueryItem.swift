//
//  URL+QueryItem.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import Alamofire

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
