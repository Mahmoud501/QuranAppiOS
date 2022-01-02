//
//  FileManager.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/5/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class MyFileManager {
    
    func getPathOf(fileName: String, fileType: String) -> String? {
        return Bundle.main.path(forResource: fileName, ofType: fileType)
    }
    
    func readFile(fileName: String, fileType: String) -> String?{
        let fileRoot = Bundle.main.path(forResource: fileName, ofType: fileType)
        let contents =  try? String.init(contentsOfFile: fileRoot ?? "", encoding: .utf8)
        return contents
    }
        
    func readFile(url: URL) -> String?{
        let contents =  try? String.init(contentsOf: url, encoding: .utf8)
        return contents
    }
    
}
