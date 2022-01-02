//
//  TestHomeVC+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension TestHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }else {
            return presenter.filter_surhas.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let obj = THHeader1.init(frame: .zero)
            obj.reviewAyatClicked = { [weak self] in
                guard let self = self else { return }
                let vc = TestedAyat.createVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return nil
        }else {
            let obj = THHeader2.init(frame: .zero)
            obj.countTxt = "( " + "\(presenter.total_count) / 6236" + " )"
            return obj
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 0//300
            }
            return 0//195
        }else {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 110
            }
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "THCell1", for: indexPath) as! THCell1
        cell.item = presenter.filter_surhas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let vc = TestedAyat.createVC()
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}
