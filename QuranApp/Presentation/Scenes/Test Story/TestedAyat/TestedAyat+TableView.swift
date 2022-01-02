//
//  TestedAyat+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

import UIKit


extension TestedAyat: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SurhaNameCell", for: indexPath) as! HomeSurhaCell
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AyaCell", for: indexPath) as! HomeAyaCell
            cell.delegate  = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeadView.init(frame: .zero)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 100
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TVAyat.deselectRow(at: indexPath, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.25) {
            self.vuStartQuran.isHidden = true
        }
    }
}
