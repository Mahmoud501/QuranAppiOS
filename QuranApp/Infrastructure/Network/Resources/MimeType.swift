//
//  MimeType.swift
//  NetworkInfra
//
//  Created by Mahmoud on 2/1/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation

enum MimeType: String {
    
    case jpg = "image/jpeg"
    case png = "image/png"
    case mp4 = "video/mp4"
    case pdf = "application/pdf"
    
    func getFileExtension() -> String {
        switch self {
        case .jpg:
            return "jpg"
        case .png:
            return "png"
        case .mp4:
            return "mp4"
        case .pdf:
            return "pdf"
        default:
            break
        }
        
    }
}
