//
//  QuranSettingVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/13/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DropDown

class QuranSettingVC: BaseViewController {

    var presenter: QuranSettingPresenter!
    var fontTypeDown = DropDown()
    var quranFontTSizeDown = DropDown()
    var tafseerFontTSizeDown = DropDown()
    var scrollDirect = DropDown()

    @IBOutlet weak var swQuran: UISwitch!
    @IBOutlet weak var swSingleSelection: UISwitch!

    ///
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var txtFontType: ZDSkyTextField!
    @IBOutlet weak var txtQuranFontSize: ZDSkyTextField!
    @IBOutlet weak var txtTafseerFontSize: ZDSkyTextField!
    @IBOutlet weak var txtScrollDirect: ZDSkyTextField!
    
    @IBAction func saveClicked(_ sender: Any) {
        presenter.isSingleSelection = swSingleSelection.isOn
        presenter.quranWithMarks = swQuran.isOn
        let setting = presenter.saveSetting()
        AppFactory.homeVC?.changeQuranSetting(setting: setting)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapfontTypeClicked(_ sender: Any) {
        self.fontTypeDown.show()
    }
    
    @IBAction func quranfontSizeClicked(_ sender: Any) {
        self.quranFontTSizeDown.show()
    }
    
    @IBAction func tafseerfontsizeClicked(_ sender: Any) {
        self.tafseerFontTSizeDown.show()
    }
    
    @IBAction func scrollDirectClicked(_ sender: Any) {
        self.scrollDirect.show()
    }
    
}

extension QuranSettingVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = QuranSettingPresenter()
        setupUI()
        updateData()
    }
    
}


extension QuranSettingVC {
    
    func setupUI() {
        btnSave.setBackgroundLight()
        btnSave.bor(radius: 13, color: .clear)
        btnSave.layer.masksToBounds = true
        setupColoredBackground()
        vuContain.bor(radius: 13, color: .clear)
        txtFontType.placeHolder = "Quran Font Type".localized
        txtFontType.iconData = UIImage.init(named: "arrow-down")
        txtFontType.setCustomStyle =  true
        setupDropDown(txtFontType.textField, vu: txtFontType, dropdown: fontTypeDown, source: ["Cairo".localized, "Uthman".localized, "Normal".localized, "Quran Kareem Font".localized, "AlQalam Quran Majeed".localized
            , "Al Mushaf".localized ], action: "fontTypeClicked:")
        fontTypeDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.txtFontType.text = item
            self.presenter.quranFontType = index.description
        }
        
        txtScrollDirect.placeHolder = "Home Scroll".localized
        txtScrollDirect.iconData = UIImage.init(named: "arrow-down")
        txtScrollDirect.setCustomStyle =  true
        setupDropDown(txtScrollDirect.textField, vu: txtScrollDirect, dropdown: scrollDirect, source: ["Middle".localized, "Top".localized, "None".localized], action: "fontTypeClicked:")
        scrollDirect.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.txtScrollDirect.text = item
            self.presenter.scrollDirect = index.description
        }
        
        
        txtQuranFontSize.placeHolder = "Quran Font Size".localized
        txtQuranFontSize.iconData = UIImage.init(named: "arrow-down")
        txtQuranFontSize.setCustomStyle =  true
        setupDropDown(txtQuranFontSize.textField, vu: txtQuranFontSize, dropdown: quranFontTSizeDown, source: ["Normal".localized, "Large".localized, "Very Large".localized], action: "fontTypeClicked:")
        quranFontTSizeDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.txtQuranFontSize.text = item
            self.presenter.quranFontSize = index.description
        }
        
        txtTafseerFontSize.placeHolder = "Tafseer Font Size".localized
        txtTafseerFontSize.iconData = UIImage.init(named: "arrow-down")
        txtTafseerFontSize.setCustomStyle =  true
        setupDropDown(txtTafseerFontSize.textField, vu: txtTafseerFontSize, dropdown: tafseerFontTSizeDown, source: ["Normal".localized, "Large".localized, "Very Large".localized], action: "fontTypeClicked:")
        tafseerFontTSizeDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.txtTafseerFontSize.text = item
            self.presenter.tafseerFontSize = index.description
        }

        //

    }
    
    
    func updateData() {
        if presenter.quranFontType == "0" {
            txtFontType.text = fontTypeDown.dataSource[0]
        }else if presenter.quranFontType == "1" {
            txtFontType.text = fontTypeDown.dataSource[1]
        }else if presenter.quranFontType == "2" {
            txtFontType.text = fontTypeDown.dataSource[2]
        }else if presenter.quranFontType == "3" {
            txtFontType.text = fontTypeDown.dataSource[3]
        }else if presenter.quranFontType == "4" {
            txtFontType.text = fontTypeDown.dataSource[4]
        }else if presenter.quranFontType == "5" {
            txtFontType.text = fontTypeDown.dataSource[5]
        }
        
        if presenter.quranFontSize == "0" {
            txtQuranFontSize.text = quranFontTSizeDown.dataSource[0]
        }else if presenter.quranFontSize == "1" {
            txtQuranFontSize.text = quranFontTSizeDown.dataSource[1]
        }else if presenter.quranFontSize == "2" {
            txtQuranFontSize.text = quranFontTSizeDown.dataSource[2]
        }
        
        if presenter.tafseerFontSize == "0" {
            txtTafseerFontSize.text = tafseerFontTSizeDown.dataSource[0]
        }else if presenter.tafseerFontSize == "1" {
            txtTafseerFontSize.text = tafseerFontTSizeDown.dataSource[1]
        }else if presenter.tafseerFontSize == "2" {
            txtTafseerFontSize.text = tafseerFontTSizeDown.dataSource[2]
        }
        
        if presenter.scrollDirect == "0" {
            txtScrollDirect.text = scrollDirect.dataSource[0]
        }else if presenter.scrollDirect == "1" {
            txtScrollDirect.text = scrollDirect.dataSource[1]
        }else  {
            txtScrollDirect.text = scrollDirect.dataSource[2]
        }
        swQuran.isOn = presenter.quranWithMarks
        swSingleSelection.isOn = presenter.isSingleSelection ?? false
    }
    
    
}


extension QuranSettingVC {
    
    static func createVC() -> QuranSettingVC {
           let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "QuranSettingVC") as! QuranSettingVC
           return vc
       }

    
}
