//
//  UserRepo.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class UserRepo {
    
    private let network: NetworkAdministration = NetworkAdministration()


    
    func register(user: UserModel? ,myResponse : (((UserInOut.Create.ViewModel?, NetworkError?)->())?)){
        var api_request = UserInOut.Create.Request()
        api_request.age = user?.age
        api_request.name = user?.name
        api_request.device_type = "0"
        api_request.device_token = KeychainManager.shared.getDeviceIdentifierFromKeychain()
        api_request.location = user?.location
        api_request.phone = user?.phone
        let api = AlmofireRequest<UserInOut.Create.Request>(value: api_request)
        api.path = NetworkRouter.register
        api.method = .post
        api.header = ["api-security-code": "4bgkbmu7JcOxRaV3xwKCwlpfbmtJStMo4CzpRvnCO4QwFr7qjCgTTWH3i15gtZNzQyWvhMlopT1zdMe6JS5wC77zZPavGXdUDuJuGFq7RhjOJ5Sgu8xAldOt4hy38PY7IqLeCmOJoxHxf5duXmVUb4"]
        let response = self.network.request(request: api, debug: true)        
        response?.report({ (result) in
            switch result {
            case .success(let data):

                let dict = data.convertToJson()
                let user = DictinaryPath.value(dict, path: "success.data") as? [String: Any]
                var code = DictinaryPath.value(dict, path: "success.code") as? Int
                var message = DictinaryPath.value(dict, path: "success.message") as? String
                if code == nil {
                    code = DictinaryPath.value(dict, path: "error.code") as? Int
                    message = DictinaryPath.value(dict, path: "error.message") as? String
                }
                let userModel = UserModel.init(api_model: user)
                var viewModel = UserInOut.Create.ViewModel()
                viewModel.user = userModel
                viewModel.message = message
                myResponse?(viewModel, nil)
                break
            case .failure(let err):
                
                myResponse?(nil, err as? NetworkError)
                break
            case .none:
                break
            }
        })
    }
    
    
    
    
    
}
