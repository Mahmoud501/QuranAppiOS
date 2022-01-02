//
//  ContactusPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class ContactusPresenter {
    
    weak var contactusView: ContactusView?
    private var settingRepo: SettingRepo? = SettingRepo()
    
    init(contactusView: ContactusView?) {
        self.contactusView = contactusView
    }
    
    
    func contactus(request: SettingInOut.contactus.DefaultRqeuest?) {
        
        settingRepo?.contactus(request: request, myResponse: { (model, error) in
                   self.contactusView?.finish()
                   if error == nil {
                    self.contactusView?.success(str: model?.message ?? "")
                   }else {
                       switch error {
                       case .noInternetConnection:
                           self.contactusView?.error(str: "Network Error".localized)
                           break
                       default:
                           self.contactusView?.error(str: error?.errorDescription ?? "")
                       }
                   }
               })
        
        
    }
    
    
    
}
