//
//  WordTest.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class WordTestVC: BaseViewController {

    @IBOutlet weak var TVWord: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension WordTestVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension WordTestVC {
    
    func setupUI() {
        //setupColoredBackground()
        TVWord.register(UINib.init(nibName: "WordQCell", bundle: nil), forCellReuseIdentifier: "WordQCell")
        TVWord.register(UINib.init(nibName: "WordOptionCell", bundle: nil), forCellReuseIdentifier: "WordOptionCell")
        TVWord.rowHeight = UITableView.automaticDimension
        TVWord.estimatedRowHeight = 44

    }
    
}

extension WordTestVC {
    static func createVC() -> WordTestVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "WordTestVC") as! WordTestVC
        vc.modalPresentationStyle = .fullScreen
        //vc.hidesBottomBarWhenPushed = true
        return vc
    }
}

extension WordTestVC {
    
}

