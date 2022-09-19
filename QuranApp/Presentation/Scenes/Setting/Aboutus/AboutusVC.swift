//
//  AboutusVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import ZVProgressHUD

class AboutusVC: BaseViewController {

    var presenter: AboutusPresenter?
    @IBOutlet weak var TVAbout: UITableView!
    
    
}


extension AboutusVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if presenter?.aboutus == nil {
            ZVProgressHUD.show()
            presenter?.getAbout()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AboutusPresenter.init(aboutView: self)
        setupUI()
        
    }
}


extension AboutusVC {
    
    func setupUI() {
        TVAbout.delegate = self
        TVAbout.dataSource = self
        TVAbout.rowHeight = UITableView.automaticDimension
        TVAbout.estimatedRowHeight = 44
        TVAbout.register(UINib.init(nibName: "AboutCell1", bundle: nil), forCellReuseIdentifier: "cell1")
        TVAbout.register(UINib.init(nibName: "AboutCell2", bundle: nil), forCellReuseIdentifier: "cell2")
        self.setupColoredBackground()
    }
    
}



extension AboutusVC {
    static func createVC() -> AboutusVC {
          let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "AboutusVC") as! AboutusVC
          vc.modalPresentationStyle = .fullScreen
          return vc
      }
}

