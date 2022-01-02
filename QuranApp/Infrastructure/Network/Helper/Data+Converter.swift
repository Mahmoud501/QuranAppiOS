//
//  Data+Converter.swift
//  NetworkInfra
//
//  Created by Mahmoud on 2/1/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation

extension Data {
    
    func convertToJson() -> [String : Any]?{
        let json = try? JSONSerialization.jsonObject(with: self, options: []) as? [String : Any]
        return json
    }
    
    func convertTo<T: Decodable>(to: T.Type) -> T?{
        let decoder = JSONDecoder()
        do {
           _ = try decoder.decode(to.self, from: self)
        } catch let DecodingError.typeMismatch(type, context)  {
           print("Type '\(type)' mismatch:", context.debugDescription)
           print("codingPath:", context.codingPath)
        }catch {
            // Catch any other errors
        }

        return  try? decoder.decode(to.self, from: self)
    }
    
}
