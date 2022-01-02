//
//  SettingHomeVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SettingHomeVC: BaseViewController {

    
    var presenter: SettingHomePresenter?
    //, "Setting.title.4".localized
    var arr = ["Setting.title.5".localized ,"Setting.title.1".localized, "Setting.title.2".localized, "Setting.title.3".localized]
    
    //
    
    @IBOutlet weak var TVSetting: UITableView!
    

}

extension SettingHomeVC {
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if presenter?.facebook == nil {
            presenter?.getSetting()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SettingHomePresenter.init(settingView: self)
        setupUI()
    }
    
}

extension SettingHomeVC {
    func setupUI() {
        TVSetting.separatorStyle = .none
        TVSetting.rowHeight = UITableView.automaticDimension
        TVSetting.estimatedRowHeight = 44
        TVSetting.delegate = self
        TVSetting.dataSource = self
        TVSetting.register(UINib.init(nibName: "SettingCell1", bundle: nil), forCellReuseIdentifier: "cell1")
        TVSetting.register(UINib.init(nibName: "SettingCell2", bundle: nil), forCellReuseIdentifier: "cell2")
        self.setupColoredBackground()
        
    }
}


extension SettingHomeVC {
    
    static func createVC() -> SettingHomeVC {
        let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingHomeVC") as! SettingHomeVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    
}


