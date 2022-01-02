//
//  SettingHomeVC+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit


extension SettingHomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return  arr.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SettingCell1
            cell.lblTitle.text = arr[indexPath.row]
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! SettingCell2
            let last_version = presenter?.lastVersion?.description ?? ""
            let current_version = presenter?.currentVersion.description ?? ""
            let text1 = "Current Version".localized + " (" + current_version + ")"
            let text2 = "Last Version in Store".localized + " (" + last_version + ")"
            if last_version == "" {
                cell.version = text1
            }else {
                cell.version = text1 + "\n" + text2
            }
            cell.facebook = presenter?.facebook
            cell.twitter = presenter?.twitter
            return cell
        }        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVSetting.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
            if indexPath.row == 0 {
                let vc = QuranSettingVC.createVC()
                self.present(vc, animated: true, completion: nil)
            }
            else if indexPath.row == 1 {//change reciter
                let vc = SelectReciterVC.createVC()
                if #available(iOS 13.0, *) {
                    vc.modalPresentationStyle = .automatic
                } else {
                    // Fallback on earlier versions
                }
                vc.type = 1
                self.present(vc, animated: true, completion: nil)
            }else if indexPath.row == 2 {//change tafseer
                let vc = SelectTafseerVC.createVC(type: 1)
                self.present(vc, animated: true, completion: nil)
            }else if indexPath.row == 3 {//contact us
                let vc = ContactusVC.createVC()
                self.present(vc, animated: true, completion: nil)
                
            }else if indexPath.row == 4 {//how to use
                let vc = FAQViewController.createFAQViewController()
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
    
}
