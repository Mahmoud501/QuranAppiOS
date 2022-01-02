//
//  TafseerProtocol.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

protocol SelectTafseerDataSource {
    
    var selected_id: String? { get set }
    var tafseers: [CTafseerModel]? { get set }
    
}



protocol SelectTafseerBusiness {
    
    
    func getTafseers(finish: ()->())
    
    func saveSelectedTafseer(tafseer: CTafseerModel)
    
    func downloadTafseer(tafseer: CTafseerModel?)
    
}


protocol TafseerDownloadView: class {
    
    func finish()
    func success()
    func failure()
    
}
