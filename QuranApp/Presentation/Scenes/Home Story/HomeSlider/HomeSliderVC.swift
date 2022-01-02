//
//  HomeSliderVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/16/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import LGSideMenuController

class HomeSliderVC: BaseViewController {
    
    
    var presenter: HomeSliderPresenter!
    
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var vuDownload: UIView!
    @IBOutlet weak var vuRepetition: ZMIBadgeView!
    @IBOutlet weak var vuInterval: UIView!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var vuImage: UIView!
    @IBOutlet weak var vuContainShadow: UIView!
    @IBOutlet weak var TVContainer: UITableView!
    @IBOutlet weak var CHeigthImg: NSLayoutConstraint!
    @IBOutlet weak var btnRepeat: UIButton!
    @IBOutlet weak var vuBadgeRepeat: ZMIBadgeView!
    @IBOutlet weak var vuBadgeDownload: ZMIBadgeView!
    @IBOutlet weak var vuBadgeInterval: ZMIBadgeView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var ImgReciter: UIImageView!
    
    var didSelectReciter: (()->())?
    
    @IBAction func downloadClicked(_ sender: Any) {
        showDownloadPopup()
    }
    
    @IBAction func repeatClicked(_ sender: Any) {
        showRepeatPopup()
    }
    
    @IBAction func intervalClicked(_ sender: Any) {
        showIntervalPopup()
    }
    
    
    
    //
    
    @IBAction func editClicked(_ sender: Any) {
        let vc = SelectReciterVC.createVC()
        vc.didSelectReciter = { [weak self] in
            guard let self = self else { return }
            self.didSelectReciter?()
            self.bind()
            self.refreehTable()
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


extension HomeSliderVC {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomeSliderPresenter()
        setupUI()
        presenter.getSurhas { [weak self] in
            guard let self = self else { return }
            self.TVContainer.reloadData()
        }
        bind()
        refreehTable()
    }
    
}


extension HomeSliderVC {
    
    func setupUI() {
        DispatchQueue.main.async {
            self.setupColoredBackground()
            self.vuDownload.setupGradientColor()
            self.vuDownload.setCirleCornerRadius()
            self.vuRepetition.setupGradientColor()
            self.vuRepetition.setCirleCornerRadius()
            self.vuInterval.setupGradientColor()
            self.vuInterval.setCirleCornerRadius()
            self.vuContain.setBackgroundLight()
            self.vuContain.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            self.vuContain.layer.cornerRadius = 18
            self.vuContain.layer.masksToBounds = true
            self.vuImage.setCirleCornerRadius()
            self.vuContainShadow.shadow33()
            self.showOptions(show: true)
        }
        TVContainer.register(UINib.init(nibName: "DownloadCell", bundle: nil), forCellReuseIdentifier: "cell")
        TVContainer.rowHeight = UITableView.automaticDimension
        TVContainer.estimatedRowHeight = 44
    }
    
    
    func showOptions(show: Bool) {
        DispatchQueue.main.async {
            if self.CHeigthImg == nil { return }
            self.view.change(width: show == true ? 0.2 : 0.0001, conts: self.CHeigthImg,finish: { conts in
                self.CHeigthImg = conts
            })
            UIView.animate(withDuration: 0.5) {
                self.vuContain.alpha = show == true ? 1 : 0
            }
        }
    }
    
    
    func showDownloadPopup() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        let optionMenu = UIAlertController(title: "Download".localized, message: "Down.message".localized, preferredStyle: .actionSheet)
         
         let OkAction = UIAlertAction(title: "Ok".localized, style: .default) { (UIAlertAction) in
            self.download(surhas: self.presenter.surhas ?? [])
         }
        
        let CancelDownloadAction = UIAlertAction(title: "Stop Download".localized, style: .destructive) { (UIAlertAction) in
            self.cancelAll() 
        }
        
         let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
         // 4
         optionMenu.addAction(OkAction)
        optionMenu.addAction(CancelDownloadAction)
         optionMenu.addAction(cancelAction)
         // 5
         optionMenu.modalPresentationStyle = .popover
         if let popoverController = optionMenu.popoverPresentationController {
             popoverController.sourceView = self.view //to set the source of your alert
             popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
             popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
         }
         self.present(optionMenu, animated: true, completion: nil)

    }
    
    func showIntervalPopup() {
         UIImpactFeedbackGenerator(style: .light).impactOccurred()
         let optionMenu = UIAlertController(title: "Interval Time".localized, message: "intev.message".localized, preferredStyle: .alert)
         
         optionMenu.addTextField(configurationHandler: nil)
         
         let textfield = optionMenu.textFields?.first
         textfield?.keyboardType = .numberPad
         
         let OkAction = UIAlertAction(title: "Ok".localized, style: .default) { (UIAlertAction) in
            self.vuBadgeInterval.badgeString = textfield?.text
            self.presenter.saveDelayTime(time: textfield?.text?.replacedArabicDigitsWithEnglish ?? "0")
         }
        
         let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
         // 4
         optionMenu.addAction(OkAction)
         optionMenu.addAction(cancelAction)
         // 5
         optionMenu.modalPresentationStyle = .popover
         if let popoverController = optionMenu.popoverPresentationController {
             popoverController.sourceView = self.view //to set the source of your alert
             popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
             popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
         }
         self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func showRepeatPopup() {
         UIImpactFeedbackGenerator(style: .light).impactOccurred()
         let optionMenu = UIAlertController(title: "Repeat Time".localized, message: "repeat.message".localized, preferredStyle: .alert)
         
         optionMenu.addTextField(configurationHandler: nil)
         
         let textfield = optionMenu.textFields?.first
         textfield?.keyboardType = .numberPad
         
         let OkAction = UIAlertAction(title: "Ok".localized, style: .default) { (UIAlertAction) in
             self.vuBadgeRepeat.badgeString = textfield?.text
            self.presenter.saveRepeatTime(time: textfield?.text?.replacedArabicDigitsWithEnglish ?? "0")
         }
        
        
         let cancelAction = UIAlertAction(title: "Cancel".localized, style: .cancel)
         // 4
         optionMenu.addAction(OkAction)
         optionMenu.addAction(cancelAction)
         // 5
         optionMenu.modalPresentationStyle = .popover
         if let popoverController = optionMenu.popoverPresentationController {
             popoverController.sourceView = self.view //to set the source of your alert
             popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
             popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
         }
         self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    
}

extension HomeSliderVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.surhas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DownloadCell
        let surha = presenter.surhas?[indexPath.row]
        cell.surha = surha
        let download = presenter.isDownloaded[indexPath.row]
        cell.download = download
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vu = DownloadHeaderView.init(frame: CGRect.zero)
        vu.downDidClicked = { [weak self] in
            guard let self = self else { return }
            self.showDownloadPopup()
        }
        return vu
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVContainer.deselectRow(at: indexPath, animated: true)
        let surha = presenter.surhas?[indexPath.row]
        download(surhas: [surha!])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 88
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 100 {
           // showOptions(show: false)
        }else {
            //showOptions(show: true)
        }
    }
}


extension HomeSliderVC {
    
    static func createVC() -> HomeSliderVC {
          let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeSliderVC") as! HomeSliderVC
          vc.modalPresentationStyle = .fullScreen
          return vc
      }

    
}
