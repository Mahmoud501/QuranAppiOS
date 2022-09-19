//
//  AyaDetailVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class AyaDetailVC: BaseViewController {

    deinit {
        print("deinit AyaDetailVC")
    }
    
    var ayah: CAyatModel?
    var setting: CSetting? {
        get {
            let repoSetting = CoreDataRepository<CSetting>.init()
            return repoSetting.getAll()?.first
        }
    }
    var reload: (()->())?
    ///
    
    @IBOutlet weak var vuBackground: UIView!
    @IBOutlet weak var lblSurhaName: UILabel!
    @IBOutlet weak var lblAyah: UILabel!
    @IBOutlet weak var lbltafseer: UILabel!
    @IBOutlet weak var lblAyahNum: UILabel!
    @IBOutlet weak var vuOptions: AyaOptionsView!
    @IBOutlet weak var vuScroll: UIScrollView!
    @IBOutlet weak var imgReciter: UIImageView!
    @IBOutlet weak var lblReciterName: UILabel!
    
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectReciterClicked(_ sender: Any) {
        let vc = SelectReciterVC.createVC()
        vc.didSelectReciter = { [weak self] in
            guard let self = self else { return }
            self.bindReciter()
            self.vuOptions.player.resetParamerter()
            self.vuOptions.playAyat()
        }
        vc.type = 1
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        self.present(vc, animated: true, completion: nil)

    }
    
    

}

extension AyaDetailVC {
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.vuOptions.player.pause()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.tabBarController?.custom?.buttonCenterRef.alpha = 0
    }
}


extension AyaDetailVC {
    
    func setupUI() {
        vuOptions.hideWriteView = self.vuScroll
        imgReciter.setCirleCornerRadius()
        self.bindReciter()
        let selectReciter = self.sideMenuController?.sliderVC()
        selectReciter?.didSelectReciter = { [weak self] in
            self?.bindReciter()
            self?.vuOptions.player.resetParamerter()
        }
        self.view.setupGradientColor()
        vuOptions.vc = self
        if let ayah = ayah {
            vuOptions.selectedAyat  = [ayah.id ?? "": ayah]
        }
        DispatchQueue.main.async {
            self.vuScroll.alignTextVerticallyInContainer()
        }
        bind(ayah: ayah, setting: setting)
        setupOPtionsView()
    }
    
    
    func setupOPtionsView() {
        vuOptions.colorAyat = { [weak self] in
            guard let self = self else { return }
            self.reload?()
            
        }
        
        vuOptions.memorizedAyat = { [weak self] in
            guard let self = self else { return }
            self.reload?()
        }
    }
    
    func bindReciter() {
        let reciter = AppFactory.currentReciter
        self.imgReciter.image = UIImage.init(named: reciter?.image_path  ?? "")
        self.lblReciterName.text = AppFactory.isArabic == true ? reciter?.name_ar : reciter?.name_en

    }
    
    
    func bind(ayah: CAyatModel?, setting: CSetting?) {
        let tafseers = (ayah?.tafseers?.array as? [CTafseerDetailModel])
        let tafseer = tafseers?.first(where: { $0.tafseer_id == TafseerName.Moyaseer.rawValue})
        self.lbltafseer.text = tafseer?.desc
        self.lblSurhaName.text = ayah?.surha?.name_ar
        self.lblAyahNum.text = "[" + "Ayah.no".localized + (ayah?.sort.description ?? "") + "]"
        if setting?.quranWithMark == true {
            self.lblAyah.text = ayah?.desc
        }else {
            self.lblAyah.text = ayah?.simple_desc
        }
        var fontType = ""
        if setting?.font_type == "0" {
            fontType = "Cairo-Bold"
        }else if setting?.font_type == "1" {
            fontType = "KFGQPCHAFSUthmanicScript-Regula"
        }else  if setting?.font_type == "2" {
            fontType = "Quran-Standard"
        }else if setting?.font_type == "3" {
            fontType = "Al-QuranAlKareem"
        }else if setting?.font_type == "4" {
            fontType = "AlQalamQuranMajeedWeb"
        }else {
            fontType = "Al_Mushaf"
        }
        self.lblAyah.font = UIFont.init(name: fontType, size: self.lblAyah.font.pointSize)
    }

    
}

extension AyaDetailVC {
    
    static func createVC(ayah: CAyatModel?) -> AyaDetailVC {
        let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "AyaDetailVC") as! AyaDetailVC
        vc.ayah = ayah
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
    
}



extension UIScrollView {
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
    
  
    
}
