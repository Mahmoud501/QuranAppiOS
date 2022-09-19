//
//  SelectTafseerVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/17/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import ZVProgressHUD

class SelectTafseerVC: BaseViewController {
    
    var didSelectTafseer: ((CTafseerModel?) -> ())?
    var presenter: SelectTafseerPresenter?
    
    @IBOutlet weak var TVTafseer: UITableView!
    
    @IBAction func baclClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.getTafseers { [weak self] in
            guard let self = self else { return }
            self.TVTafseer.reloadData()
        }
        
    }
    
    func setupUI() {
        self.setupColoredBackground()
        TVTafseer.delegate = self
        TVTafseer.dataSource = self
        TVTafseer.register(UINib.init(nibName: "SelectTafseerCell", bundle: nil), forCellReuseIdentifier: "cell")
        TVTafseer.rowHeight = UITableView.automaticDimension
        TVTafseer.estimatedRowHeight = 44
    }
    
    func alert(tafseer: CTafseerModel?) {
        let name = (AppFactory.isArabic == true ? tafseer?.name_ar : tafseer?.name_en) ?? ""
        let alertDownload = UIAlertController.init(title: name, message: "do you want to download tafseer?".localized, preferredStyle: UIAlertController.Style.alert)
        let action1 = UIAlertAction.init(title: "Download".localized, style: UIAlertAction.Style.default) { (alert) in
            ZVProgressHUD.show()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
               self.presenter?.downloadTafseer(tafseer: tafseer)
            })
        }
        let action2 = UIAlertAction.init(title: "Cancel".localized, style: UIAlertAction.Style.destructive) { (alert) in
            
        }
        alertDownload.addAction(action2)
        alertDownload.addAction(action1)
        alertDownload.modalPresentationStyle = .popover
              if let popoverController = alertDownload.popoverPresentationController {
                  popoverController.sourceView = self.view //to set the source of your alert
                  popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                  popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
              }
        self.present(alertDownload, animated: true, completion: nil)
        
    }

}


extension SelectTafseerVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tafseers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectTafseerCell
        let tafseer = presenter?.tafseers?[indexPath.row]
        if presenter?.selected_id == tafseer?.id {
            cell.backgroundColor = .c3
        }else {
            cell.backgroundColor = .white
        }
        cell.tafseer = tafseer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tafseer = presenter?.tafseers?[indexPath.row]
        if (tafseer?.downloaded ?? false) == true {
            presenter?.saveSelectedTafseer(tafseer: tafseer!)
            AppFactory.homeVC?.didChangeTafseer()
            self.didSelectTafseer?(tafseer)
            self.dismiss(animated: true, completion: nil)
        }else {
            alert(tafseer: tafseer)
        }
    }
}

extension SelectTafseerVC {
    
    static func createVC(type: Int) -> SelectTafseerVC {
          let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SelectTafseerVC") as! SelectTafseerVC
        if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .automatic
        } else {
            // Fallback on earlier versions
        }
        vc.presenter = SelectTafseerPresenter(downloadView: vc,type: type)
        return vc
      }

    
}
