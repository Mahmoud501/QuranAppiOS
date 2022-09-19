//
//  PageManger.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/5/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class PageManger {
    
    var fileManager: MyFileManager = MyFileManager()

    private func handleStartPage(arr: [CPage]) -> [CPage]{
        var i: Int32 = 1
        for item in arr {
            item.start = i
            i += item.number_ayat
            
            
        }
        return arr
    }
    
    
    func installPage() -> [CPage] {
        var arr = [CPage]()
        let content = fileManager.readFile(fileName: "page-file", fileType: "txt")
        let pageAyatNumbers = content?.split(separator: "\r\n")
        var index = 1
        let repo = CoreDataRepository<CPage>.init()        
        for item in pageAyatNumbers ?? [] {
            if let ayatNum = Int32(item.description) {
                let p1 = CPage.init(context: repo.context!)
                p1.id = index.description
                p1.idInt = Int16(index)
                p1.number_ayat = ayatNum
                p1.name_en = "Page Number " + index.description
                p1.name_ar = "الصفحة رقم " + index.description.replacedArabicDigitsWithEnglish
                arr.append(p1)
                index += 1
            }else {}
        }
        arr = handleStartPage(arr: arr)
        return arr
    }
    
    
    static func test() throws {
        let pm = PageManger()
        let arr =  pm.installPage()
        var sum: Int32 = 0
        for it in arr {
            if it.number_ayat <= 0 {
                print(it)
                throw NSError.init(domain: "error ", code: 11, userInfo: nil)
            }
            sum += it.number_ayat
            print(it.id , " " , it.number_ayat, it.start, "  to "  , (it.start + (it.number_ayat - 1)))
        }
        
        print(arr.count)
        print(sum)

    }
    
}
