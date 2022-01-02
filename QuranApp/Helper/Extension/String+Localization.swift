//
//  String+Localization.swift
//  FOODTRUCK
//
//  Created by Mahmoud on 4/31/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation

extension String{
    var localized:String{
        return NSLocalizedString(self, comment: "")
    }
}
