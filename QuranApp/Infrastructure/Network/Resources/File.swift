//
//  APIRequestDataSource.swift
//  NetworkInfra
//
//  Created by Mahmoud on 1/31/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation



//like -> Image
struct File {
    
    let name: String
    let key: String
    let mimeType: MimeType
    let data: Data
    var value: Any? = nil
    
}

//like -> Image
struct DownloadFile {
    
    let name: String
    let mimeType: MimeType
    
}
