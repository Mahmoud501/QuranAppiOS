//
//  String+SearchFliter.swift
//  VoiceTest
//
//  Created by MAJED A  ALGARNI on 10/21/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


extension String {
    
        public var ayahFilter: String {
            var str = self

            let map =   [
                
            "ال": "" ,

    "أ": "ا",

    "إ": "ا",

    "ى": "ي",

    "آ": "ا",
    
    ]
                 
            map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
            return str
        }
    
    
           public var ayahFilter2: String {
               var str = self

               let map =   [
     
       "أ": "ا",

       "إ": "ا",

       "ى": "ي",

       "آ": "ا",
       
       ]
                    
               map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
               return str
           }
       
    
    
    
    public var searchFilter: String {
        var str = self

        let map =   [
        "ال": "" ,

"أ": "ا",

"إ": "ا",

"ى": "ي",

"آ": "ا",

"ث": "ت",

"ياسين":"يس",

"يسين": "يس",

"": "",


]
             
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    public var JuzhFliter: String {
            var str = self

            let map =   [

                     "ين": "ون"
                
        ]

            map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
            return str
        }
    
    
    
    public var pageFliter: String {
        var str = self

        let map =   [
            "اول": "1",
"واحد":"1",
            
            "اتنين": "2",
            
"تلاتة":"3",

"اربعة":"4",

"خمسة":"5",

"ستة":"6",

"سبعة":"7",

"تمانية":"8",

"تسعة": "9",

"عشرة": "10",

        ]

        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
    
    public var ayahVoiceFilter: String {
        var str = self

        let map =   [
            
            "و": "ؤ" ,
            "ص": "س" ,
        ]
             
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    
}
