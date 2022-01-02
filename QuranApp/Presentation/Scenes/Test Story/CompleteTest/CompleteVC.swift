//
//  CompleteVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
struct dataCom {
    
    var error: String?
    var isCom: Bool?
    var ayah: CAyatModel?
    
}


class CompleteVC: UIViewController {

    var ayat: [CAyatModel]? {
        didSet {
            let ids = getAyatCompleteIds()
            ayat_com = [dataCom]()
            for item in ayat ?? [] {
                var ayah = dataCom.init(ayah: item)
                if ids.contains(item.id ?? "111111111") == true {
                    ayah.isCom  = true
                }else {
                    ayah.isCom  = false
                }
                ayat_com?.append(ayah)
            }
        }
    }
    
    
    var ayat_com: [dataCom]? //ayat id that must be compelete

    
    @IBOutlet weak var TVCompleteAyat: UITableView!
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}


extension CompleteVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
}


extension CompleteVC {
    func setupUI() {
        TVCompleteAyat.register(UINib.init(nibName: "CompleteTestCell", bundle: nil), forCellReuseIdentifier: "CompleteTestCell")
        TVCompleteAyat.rowHeight = UITableView.automaticDimension
        TVCompleteAyat.estimatedRowHeight = 44
    }
}


extension CompleteVC {
    
    static func createVC() -> CompleteVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "CompleteVC") as! CompleteVC
        vc.modalPresentationStyle = .fullScreen
       // vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
}
