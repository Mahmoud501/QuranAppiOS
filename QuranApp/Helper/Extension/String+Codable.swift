//
//  String+Codable.swift
//  Wagb3aza
//
//  Created by Mahmoud on 7/17/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation
extension String
{
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
    }
}
