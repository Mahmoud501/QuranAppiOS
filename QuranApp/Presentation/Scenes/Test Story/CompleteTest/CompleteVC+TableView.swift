//
//  CompleteVC+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension CompleteVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ayat_com?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompleteTestCell", for: indexPath) as! CompleteTestCell
        let ayah = ayat_com?[indexPath.row]
        cell.ayah = ayah
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = CompleteTestHeader.init(frame: .zero)
        header.text = "com.t1".localized
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
        
            return 100
        
        }
               
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVCompleteAyat.deselectRow(at: indexPath, animated: true)
        let ayah = ayat_com?[indexPath.row]
        if ayah?.isCom == true {
            let vc2 = WriteTestVC.createVC(parentView: self.view, hideView: self.TVCompleteAyat)
            vc2.orderAyat = [ayah!.ayah!]
            vc2.type = 2
            vc2.result = { [weak self] (result) in
                self?.ayat_com?[indexPath.row].isCom = false
                if result == nil {
                }else {
                    self?.ayat_com?[indexPath.row].error = result
                }
                self?.TVCompleteAyat.reloadData()
            }
            self.present(vc2, animated: true, completion: nil)
        }else {
            
        }

    }
    
    
  
}
