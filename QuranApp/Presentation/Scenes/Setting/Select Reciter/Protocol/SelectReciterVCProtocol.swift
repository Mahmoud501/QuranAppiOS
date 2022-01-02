//
//  SelectReciterVCProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

protocol SelectReciterDataSource {
        
    var current_reciter: String? { get set }
    var current_type: Int16? { get set }
    var reciters: [CReciter]? { get set }
    
}

protocol SelectReciterDelegate {
    
    func getReciters(finish: ()->())
    
    func saveSelectedReciter(reciter: CReciter)
    
    func getName() -> String?
}
