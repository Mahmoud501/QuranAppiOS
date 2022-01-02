//
//  HomeProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


protocol HomeDataSource {
    
    var reciter: CReciter? { get }
    var QuranType: String? { get set }
    var tafseer_id: String? { get }
    var selectedAyat: Dictionary<String, CAyatModel>? { get set }
    var pages: [CPage]? { get set } //lazy
    var surhas: [CSurha]? { get set } //lazy
    var juzhs: [CJuzh]? { get set } //lazy
        
}


protocol HomeBusiness {
    
    func getPages(finish: ()->()) -> [CPage]?
    func getSurhas(finish: ()->()) -> [CSurha]?
    func getJuzhs(finish: ()->()) -> [CJuzh]?

    
}
