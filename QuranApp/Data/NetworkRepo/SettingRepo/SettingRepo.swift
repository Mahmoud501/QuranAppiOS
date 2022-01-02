//
//  SettingRepo.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class SettingRepo {
    
    private let network: NetworkAdministration = NetworkAdministration()


    
    func getAbout(myResponse : (((SettingInOut.getAbout.ViewModel?, NetworkError?)->())?)){
        var api_request = SettingInOut.getAbout.Request()
        let api = AlmofireRequest<SettingInOut.getAbout.Request>(value: api_request)
        api.path = NetworkRouter.about
        api.method = .get
        api.header = ["api-security-code": "4bgkbmu7JcOxRaV3xwKCwlpfbmtJStMo4CzpRvnCO4QwFr7qjCgTTWH3i15gtZNzQyWvhMlopT1zdMe6JS5wC77zZPavGXdUDuJuGFq7RhjOJ5Sgu8xAldOt4hy38PY7IqLeCmOJoxHxf5duXmVUb4"]
        let response = self.network.request(request: api, debug: true)
               
        response?.report({ (result) in
            switch result {
            case .success(let data):

                let dict = data.convertToJson()
                var code = DictinaryPath.value(dict, path: "success.code") as? Int
                var message = DictinaryPath.value(dict, path: "success.message") as? String
                if code == nil {
                    code = DictinaryPath.value(dict, path: "error.code") as? Int
                    message = DictinaryPath.value(dict, path: "error.message") as? String
                }
                var viewModel = SettingInOut.getAbout.ViewModel()
                let team =  DictinaryPath.value(dict, path: "success.data.teams") as? [[String: Any]]
                viewModel.team =  team?.map{ TeamMemberModel.init(dict: $0) }
                viewModel.aboutus = DictinaryPath.value(dict, path: "success.data.about_us.body") as? String
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
    
    func getSetting(myResponse : (((SettingInOut.getSetting.ViewModel?, NetworkError?)->())?)){
        var api_request = SettingInOut.getSetting.Request()
        let api = AlmofireRequest<SettingInOut.getSetting.Request>(value: api_request)
        api.path = NetworkRouter.setting
        api.method = .get
        api.header = ["api-security-code": "4bgkbmu7JcOxRaV3xwKCwlpfbmtJStMo4CzpRvnCO4QwFr7qjCgTTWH3i15gtZNzQyWvhMlopT1zdMe6JS5wC77zZPavGXdUDuJuGFq7RhjOJ5Sgu8xAldOt4hy38PY7IqLeCmOJoxHxf5duXmVUb4"]
        let response = self.network.request(request: api, debug: true)
               
        response?.report({ (result) in
            switch result {
            case .success(let data):

                let dict = data.convertToJson()
                var code = DictinaryPath.value(dict, path: "success.code") as? Int
                var message = DictinaryPath.value(dict, path: "success.message") as? String
                if code == nil {
                    code = DictinaryPath.value(dict, path: "error.code") as? Int
                    message = DictinaryPath.value(dict, path: "error.message") as? String
                }
                var viewModel = SettingInOut.getSetting.ViewModel()
                viewModel.faceook = DictinaryPath.value(dict, path: "success.data.facebook") as? String
                viewModel.twitter = DictinaryPath.value(dict, path: "success.data.twitter") as? String
                viewModel.last_version_ios = DictinaryPath.value(dict, path: "success.data.last_version_ios") as? Int
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
    
    func contactus(request: SettingInOut.contactus.DefaultRqeuest? ,myResponse : (((SettingInOut.contactus.ViewModel?, NetworkError?)->())?)){
         var api_request = SettingInOut.contactus.Request()
         api_request.subject = request?.subject
         api_request.name = request?.name
         api_request.email = request?.email
        api_request.body = request?.body
         let api = AlmofireRequest<SettingInOut.contactus.Request>(value: api_request)
         api.path = NetworkRouter.contactus
         api.method = .post
         api.header = ["api-security-code": "4bgkbmu7JcOxRaV3xwKCwlpfbmtJStMo4CzpRvnCO4QwFr7qjCgTTWH3i15gtZNzQyWvhMlopT1zdMe6JS5wC77zZPavGXdUDuJuGFq7RhjOJ5Sgu8xAldOt4hy38PY7IqLeCmOJoxHxf5duXmVUb4"]
         let response = self.network.request(request: api, debug: true)
                
         response?.report({ (result) in
             switch result {
             case .success(let data):

                 let dict = data.convertToJson()
                 var code = DictinaryPath.value(dict, path: "success.code") as? Int
                 var message = DictinaryPath.value(dict, path: "success.message") as? String
                 if code == nil {
                     code = DictinaryPath.value(dict, path: "error.code") as? Int
                     message = DictinaryPath.value(dict, path: "error.message") as? String
                 }
                 var viewModel = SettingInOut.contactus.ViewModel()
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
    

    func downloadFile(finish: (()->())?){
        let url = ""
        let fileName = "PDFQuranTajweed"
        
        savePdf(urlString: url, fileName: fileName)
        finish?()
    }

    func getExistPath() -> String? {
        let fileName = "PDFQuranTajweed"
        let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        let pdfNameFromUrl = "\(fileName).pdf"
        let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
        if FileManager.default.fileExists(atPath: actualPath.path) {
            return actualPath.absoluteString
        }else {
            return nil
        }
    }
    
    
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.global(qos: .userInitiated).async {
                let url = URL(string: urlString)
                let pdfData = try? Data.init(contentsOf: url!)
                let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
                let pdfNameFromUrl = "\(fileName).pdf"
                let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
                do {
                    try pdfData?.write(to: actualPath, options: .atomic)
                    print("pdf successfully saved!")
    //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
                } catch {
                    print("Pdf could not be saved")
                }
            }
        }
    
    
    func test(loading: ((Double)->())?, success: (()->())?, failure: ((String)->())?){
        
        let api_request = SettingInOut.EmptyDown()
         let api = AlmofireRequest<SettingInOut.EmptyDown>(value: api_request)
        
       //https://www.tutorialspoint.com/swift/swift_tutorial.pdf //https://ia801609.us.archive.org/31/items/bensaoud_gmail_20170308_0721/%D9%85%D8%B5%D8%AD%D9%81%20%D8%A7%D9%84%D8%AA%D8%AC%D9%88%D9%8A%D8%AF%20%D8%A7%D9%84%D9%85%D9%84%D9%88%D9%86.pdf
         api.path = "http://quranapp.info/public/coran-moulawane.pdf"
         api.method = .get
        let fileName = "PDFQuranTajweed"
        let response = self.network.download(file: File(name: fileName, key: "", mimeType: .pdf, data: Data()), request: api, debug: true)
        response?.reportLoading({ (process) in
            loading?(process ?? 0)
        })
         response?.report({ (result) in
             switch result {
             case .success(let data):
                    success?()
                 break
             case .failure(let err):
                    failure?(err.localizedDescription)
                 break
             case .none:
                 break
             }
         })
     }
    

    
}
