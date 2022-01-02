//
//  OptionPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class OptionPresenter: OptionVCProtocolDataSource {
    
    var user: UserModel?
    private weak var registerView: RegisterView?
    private var userRepo: UserRepo?
    private let localRepo = CoreDataRepository<CSetting>.init()
    
    init(registerView: RegisterView?) {
        userRepo = UserRepo()
        self.registerView = registerView
    }
    
    
}


extension OptionPresenter: OptionVCProtocolBusiness {
    
    func register(user: UserModel?) {
    
        userRepo?.register(user: user, myResponse: { (model, error) in
            self.registerView?.registerFinish()
            if error == nil {
                self.cacheUser(user: model?.user)
                self.registerView?.registerSuccess()                
            }else {                
                switch error {
                case .noInternetConnection:
                    self.registerView?.registerFailNetwork()
                    break
                default:
                    self.registerView?.registerFail(error: error?.errorDescription ?? "")
                }
            }
        })
        
    }
    
    func cacheUser(user: UserModel?) {
        if let user = user {
            let userInfo = UserModelInfo(user: user)
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(userInfo)
            let json = String(data: jsonData!, encoding: String.Encoding.utf8)
            
            if let setting = localRepo.getAll()?.first {
                setting.user = json
                localRepo.register(value: setting)
            }else {
                //install setting
                let settingRepo = CoreDataRepository<CSetting>.init()
                let setting = CSetting.init(context: settingRepo.context!)
                setting.total_test = 0
                setting.ayah_delay = 0
                setting.ayah_repeat = 0
                setting.user = json
                localRepo.register(value: setting)
            }
            
        }
        
    }
        
    
}
