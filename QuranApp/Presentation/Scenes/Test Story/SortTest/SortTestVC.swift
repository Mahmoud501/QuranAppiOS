//
//  SortTestVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SortTestVC: BaseViewController {

    //
    
    var ayat: [CAyatModel]? {
        didSet {
            unsortAyat = ayat?.shuffled()
        }
    }
    var unsortAyat: [CAyatModel]?
    
    //
    
    @IBOutlet weak var TVSort: UITableView!
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkAnswerClicked(_ sender: Any) {
        
        for item in  unsortAyat ?? [] {
            print(item.desc)
        }
        
        let totalCount = ayat?.count ?? 0
        var correct = 0
        var wrong = 0
        for i  in 0 ..< totalCount  {
            if (ayat?[i].id == unsortAyat?[i].id) || (ayat?[i].desc == unsortAyat?[i].desc) {
                correct += 1
            }else {
                wrong += 1
            }
        }
        
        if correct == totalCount {
            AlertClass2.ShowSuccessMessage(vc: nil, message: "Wonderful!".localized, title: "sort.t2".localized, interact: true)
        }else {
            AlertClass2.ShowErrorStatusBar(vc: nil, message: "sort.t3".localized)
        }
        
    }
    

}


extension SortTestVC {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}


extension SortTestVC {
    
    func setupUI() {
        
        
        TVSort.register(UINib.init(nibName: "SortTestCell", bundle: nil), forCellReuseIdentifier: "SortTestCell")
        TVSort.rowHeight = UITableView.automaticDimension
        TVSort.estimatedRowHeight = 44
        TVSort.isEditing = true
        
        
    }
    
}


extension SortTestVC {
    
    static func createVC() -> SortTestVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "SortTestVC") as! SortTestVC
        vc.modalPresentationStyle = .fullScreen
       // vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
}

