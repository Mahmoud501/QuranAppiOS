//
//  HomeVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import LGSideMenuController
import DownloadButton
import AVFoundation
import Speech
import ZVProgressHUD

//test

class HomeVC: BaseViewController{
    
    var isFirst = true // first Lanuach
    var presenter: HomePresenter?
    var player: AVAudioPlayer?
    var isTabbarHidden = false
    var downloadTimer: Timer?
    var canHideBasmala = false // flag to determine can hide basmala or not to help in scroll in start of page
    var searchVC: SearchTextVC!
    var pdfQuranVC: PDFQuranVC!
    
    @IBOutlet weak var vuSwitch: UIView!
    
    @IBOutlet weak var CustomQuranPDF: UIView!
    @IBOutlet weak var vuMark: UIView!
    @IBOutlet weak var vuTop: UIView!
    @IBOutlet weak var vuReciter: UIView!
    @IBOutlet weak var ImgReciter: UIImageView!
    @IBOutlet weak var vuClose: UIView!
    @IBOutlet weak var vuDownload: UIView!
    @IBOutlet weak var vuTafseer: UIView!
    @IBOutlet weak var vuSearch: UIView!
    @IBOutlet weak var vuStartQuran: UIView!
    @IBOutlet weak var TVAyat: UITableView!
    @IBOutlet weak var ImgDownload: UIImageView!
    @IBOutlet weak var vuOptions: AyaOptionsView!
    @IBOutlet weak var vuSuperContainer: UIView!
    @IBOutlet weak var AyaOptionHeigth: NSLayoutConstraint!
    
    @IBAction func SelectReciterClicked(_ sender: Any) {
        unSelectAll()
       _ = self.sideMenuController?.show()
    }
    
    
    @IBAction func tafseerClicked(_ sender: Any) {
        let vc = SelectTafseerVC.createVC(type: 1)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        unSelectAll()
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        print("test search")
        searchVC.didSearchWith = { [weak self] (ayah) in
            guard let self = self else { return }
            self.search(ayah: ayah)
        }
        self.present(self.searchVC, animated: true, completion: nil)
    }
    
    @IBAction func settingClicked(_ sender: Any) {
        let vc = QuranSettingVC.createVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func switchQuran(_ sender: Any) {
        UIImpactFeedbackGenerator.init(style: UIImpactFeedbackGenerator.FeedbackStyle.light).impactOccurred()
        if let path = presenter?.getFilePDF() {
                    if vuSuperContainer.alpha == 1 {
                        if self.TVAyat != nil {
                            if let indexPaths = self.TVAyat.indexPathsForVisibleRows {
                                if indexPaths.count > 0 {
                                    let indexPathMiddle = ceil(Double(indexPaths.count) / Double(2.0))
                                    let IntMiddle = Int(indexPathMiddle)
                                    if let ayah = presenter?.getAyah(section: indexPaths[IntMiddle].section, row: indexPaths[IntMiddle].row) {
                                        pdfQuranVC.ayah = ayah
                                        self.vuSuperContainer.alpha = 0
                                        self.CustomQuranPDF.alpha = 1
                                        self.view.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 231/255, alpha: 1)
                                    }else if let ayah = presenter?.getAyah(section: indexPaths[IntMiddle].section, row: indexPaths[IntMiddle].row - 1) {
                                        pdfQuranVC.ayah = ayah
                                        self.vuSuperContainer.alpha = 0
                                        self.CustomQuranPDF.alpha = 1
                                        self.view.backgroundColor = UIColor.init(displayP3Red: 1, green: 1, blue: 231/255, alpha: 1)
                                    }
                                }
                            }
                        }                      
                    }else {
                        self.CustomQuranPDF.alpha = 0
                        self.vuSuperContainer.alpha = 1
                        self.view.backgroundColor = .white
                    }
        }else {
            let alertContoller = UIAlertController.init(title: "Download".localized, message: "downMessge".localized, preferredStyle: UIAlertController.Style.alert)

            alertContoller.addAction(UIAlertAction.init(title: "Ok".localized, style: UIAlertAction.Style.default, handler: { (com) in
                self.presenter?.networkSetting.test(loading: { (process) in                    
                    ZVProgressHUD.showProgress(Float(process))
                }, success: {
                    AlertClass2.ShowSuccessMessage(vc: nil, message: "downMessgeSucc".localized, title: "Download".localized, interact: true)
                    self.pdfQuranVC.path = self.presenter?.getFilePDF()
                    self.pdfQuranVC.openPDF()
                    ZVProgressHUD.dismiss()
                }, failure: { (err) in
                    ZVProgressHUD.dismiss()
                    AlertClass2.ShowErrorStatusBar(vc: nil, message: err)
                })
            }))
            alertContoller.addAction(UIAlertAction.init(title: "Cancel".localized, style: UIAlertAction.Style.destructive, handler: nil))
            alertContoller.modalPresentationStyle = .popover
                  if let popoverController = alertContoller.popoverPresentationController {
                      popoverController.sourceView = self.view //to set the source of your alert
                      popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                      popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                  }
            self.present(alertContoller, animated: true, completion: nil)
            
        }

    }
    
    @IBAction func markClicked(_ sender: Any) {
        if let ayah = presenter?.getMarkAyah() {
            self.scrollToAyah(ayah: ayah, animation: true)
        }     
    }
    
}




extension HomeVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
             self.tabBarController?.custom?.buttonCenterRef.alpha = 1
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.view.layoutIfNeeded()
        self.tabBarController?.tabBar.layoutIfNeeded()
        self.tabBarController?.view.setNeedsLayout()
        self.tabBarController?.tabBar.setNeedsLayout()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        AppFactory.homeVC = self
        presenter = HomePresenter()
        searchVC = SearchTextVC.createVC()
        setupUI()
        didChangeReciter()
        presenter?.getHome { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.TVAyat.reloadData()
                self.goToLastCell()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirst {
            isFirst = false
            self.vuSuperContainer.setupGradientColor()
        }
    }
    
}


extension HomeVC {
    
    func setupUI() {
        let updateSurha = UserDefaultClass.getValue("updateSurha") as? Bool
        if updateSurha == nil {
            SurhaManger.correctSurhaNames()
            AppFactory.homeVC?.TVAyat.reloadData()
            UserDefaultClass.setValue("updateSurha", true)
        }
        vuOptions.hideWriteView = self.TVAyat
        vuMark.setCirleCornerRadius()
        self.vuOptions.alpha = 0
        vuClose.isHidden = true
        setupAyatOptions()
        vuTop.backgroundColor = .clear
        vuReciter.layer.masksToBounds = true
        vuReciter.bor(radius: vuReciter.frame.width / 2, color: .white, w: 2)        
        vuClose.setCirleCornerRadius()
        vuTafseer.setCirleCornerRadius()
        vuSearch.setCirleCornerRadius()
        vuDownload.setCirleCornerRadius()
        self.vuSwitch.setCirleCornerRadius()
        vuStartQuran.backgroundColor = .clear
        TVAyat.register(UINib.init(nibName: "HomeAyaCell", bundle: nil), forCellReuseIdentifier: "AyaCell")
        TVAyat.register(UINib.init(nibName: "HomeSurhaCell", bundle: nil), forCellReuseIdentifier: "SurhaNameCell")
        TVAyat.register(UINib.init(nibName: "FooterHomeCell", bundle: nil), forCellReuseIdentifier: "FooterHomeCell")        
        TVAyat.rowHeight = UITableView.automaticDimension
        TVAyat.estimatedRowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            TVAyat.sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }

        vuOptions.vc = self
       // checkPermissionMic()
         setupQuranPDF()
    }
    
    func setupQuranPDF() {
        pdfQuranVC = PDFQuranVC.createVC()
        pdfQuranVC.view.frame = self.CustomQuranPDF.frame
        self.CustomQuranPDF.alpha = 0
        self.CustomQuranPDF.addSubview(pdfQuranVC.view)
        if let path = presenter?.getFilePDF() {
            pdfQuranVC.path = path
            DispatchQueue.main.async {
                self.pdfQuranVC.openPDF()
            }
        }
    }
    


    
    func checkPermissionMic() {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
        })
        SFSpeechRecognizer.requestAuthorization { (status) in
            
        }

        
    }
    
    func showOptionWithAnimation(_ val: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            self.vuOptions.alpha = val == true ? 1 : 0
            self.vuSwitch.alpha = val == true ? 0 : 1
        }) { (com) in
            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
                self.vuSwitch.layoutIfNeeded()
                self.vuSwitch.setNeedsLayout()
            }
        }
    }
    
    func showCloseWithAnimation(_ val: Bool) {
        self.vuClose.alpha = 1
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
            self.vuClose.isHidden = !val
            if val == false {
                self.vuClose.alpha = 0
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func hideBasmala() {
        UIView.animate(withDuration: 0.25) {
            self.vuStartQuran.isHidden = true
        }
    }
   
    func unSelectAll() {
        self.showCloseWithAnimation(false)
        self.presenter?.clearSelection()
        vuOptions.selectedAyat = nil
        self.TVAyat.reloadData()
        self.tabBarController?.custom?.showTabbar()
        showOptionWithAnimation(false)

    }
    
    func goToLastCell() {
        do {
            if let ayahid = UserDefaultClass.getValue("CurrentAyahInHomeID") as? String {
                      if let ayah = presenter?.getAyahId(id: ayahid) {
                          let tuple = self.presenter?.getIndexPathOf(ayah: ayah) //tuple -> section , row
                          if let tuple = tuple {
                            if (Int(ayah.id ?? "0") ?? 0) > 6 {
                                self.canHideBasmala = false
                                self.TVAyat.scrollToRow(at: IndexPath.init(row: tuple.1!, section: tuple.0!), at: UITableView.ScrollPosition.middle, animated: true)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    self.canHideBasmala = true
                                }
                            }else {
                                self.canHideBasmala = true
                            }
                          }
                      }
                  }
        }catch let err {
            
        }
      
    }
    
   
}

//extension HomeVC: PKDownloadButtonDelegate {
//
//    func simulateDownloading() {
//        downloadTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
//            guard self.vuDownload.stopDownloadButton.progress < 1 else {
//                self.vuDownload.state = .downloaded
//                self.ImgDownload.alpha = 1
//                timer.invalidate()
//                return
//            }
//            self.vuDownload.stopDownloadButton.progress += CGFloat(timer.timeInterval/15)
//        }
//        downloadTimer?.fire()
//    }
//
//
//    func downloadButtonTapped(_ downloadButton: PKDownloadButton!, currentState state: PKDownloadButtonState) {
//         switch state {
//               case .startDownload:
//                   downloadTimer?.invalidate()
//                   downloadButton.stopDownloadButton.progress = 0
//                   downloadButton.state = .pending
//                   self.ImgDownload.alpha = 0
//                   DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                       self.vuDownload.state = .downloading
//                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//                           self.simulateDownloading()
//                       }
//                   }
//               case .pending:
//                   break
//               case .downloading, .downloaded:
//                   downloadTimer?.invalidate()
//                   downloadButton.stopDownloadButton.progress = 0
//                   downloadButton.state = .startDownload
//                   self.ImgDownload.alpha = 1
//         @unknown default:
//            break
//        }
//    }
//
//}

extension PKDownloadButton {
    
    func setupButton(color: UIColor? = nil ,radiusPrecent: CGFloat? = nil ) {
        self.startDownloadButton.cleanDefaultAppearance()
        self.downloadedButton.cleanDefaultAppearance()
        self.tintColor = color ?? .white
        self.stopDownloadButton.tintColor = color ?? .white
        self.pendingView.radius = self.frame.width * (radiusPrecent ?? 0.3)
        self.stopDownloadButton.radius = self.frame.width  * (radiusPrecent ?? 0.3)

    }
    
}

extension HomeVC {
    
    static func createVC() -> UIViewController {
        let ClientHome = HomeTabbarController.createVC()
        let ViewController = HomeSliderVC.createVC()
        let sideMenuController: LGSideMenuController
        if UIApplication.isArabic {
            sideMenuController = LGSideMenuController(rootViewController: ClientHome,
                                                          leftViewController: nil,
                                                          rightViewController: ViewController)
            sideMenuController.rightViewWidth = UIScreen.main.bounds.width * 0.93
            sideMenuController.rightViewCoverAlpha = 0
            sideMenuController.rightViewPresentationStyle = .slideBelow;


        }else {
            sideMenuController = LGSideMenuController(rootViewController: ClientHome,
                                                          leftViewController: ViewController,
                                                          rightViewController: nil)
            sideMenuController.leftViewWidth = UIScreen.main.bounds.width * 0.93
            sideMenuController.leftViewCoverAlpha = 0
            sideMenuController.leftViewPresentationStyle = .slideBelow;

        }
        sideMenuController.modalPresentationStyle = .fullScreen
        return sideMenuController
    }
}

extension LGSideMenuController {
    
    func show() -> HomeSliderVC {
        var vc: HomeSliderVC
        if UIApplication.isArabic {
            self.showRightViewAnimated(sender: self)
            vc = self.rightViewController as! HomeSliderVC
        }else {
            self.showLeftViewAnimated(sender: self)
            vc = self.leftViewController as! HomeSliderVC
        }
        return vc
    }
    
    func sliderVC ()-> HomeSliderVC {
        var vc: HomeSliderVC
        if UIApplication.isArabic {
            vc = self.rightViewController as! HomeSliderVC
        }else {
            vc = self.leftViewController as! HomeSliderVC
        }
        return vc

    }
    
}

extension String {
    static func mm(string:String, regex:String) -> Bool {
        return string.range(of: regex, options: String.CompareOptions.regularExpression, range: nil, locale: nil) != nil
    }

}
