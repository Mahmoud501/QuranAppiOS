//
//  OptionVCProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

protocol OptionVCProtocolDataSource {
    
    var user: UserModel? { get set }
    
}


protocol OptionVCProtocolBusiness {
    
    func register(user: UserModel?)
    func cacheUser(user: UserModel?)
    
}

protocol RegisterView: class {
    
    func registerSuccess()
    func registerFail(error: String)
    func registerFailNetwork()
    func registerFinish()
    
}
