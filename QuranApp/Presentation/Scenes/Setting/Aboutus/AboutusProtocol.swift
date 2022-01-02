//
//  AboutusProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


protocol AboutusView: class {
    
    func success()
    func error(str: String)
    func finish()
    
}
