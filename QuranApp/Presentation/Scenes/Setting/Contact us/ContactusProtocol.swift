//
//  ContactusProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


protocol ContactusView: class {
    
    func success(str: String)
    func error(str: String)
    func finish()
    
}
