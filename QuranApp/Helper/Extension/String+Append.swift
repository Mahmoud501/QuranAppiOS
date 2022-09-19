//
//  String+Append.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/13/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

extension String {
    
    var encodeValue: String? {
        var dataenc = self.data(using: String.Encoding.nonLossyASCII)
        var encodevalue = String(data: dataenc!, encoding: String.Encoding.utf8)
        return encodevalue
    }
    
}
