//
//  HomeVC+TableView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let count = presenter?.getCountSections() ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((presenter?.getCountRows(section: section) ?? 0)) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        if indexPath.row == ((presenter?.getCountRows(section: indexPath.section) ?? 0)) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterHomeCell", for: indexPath) as! FooterHomeCell
            return cell
        }
        let ayah = presenter?.getAyah(section: indexPath.section, row: (indexPath.row))
        let cell = tableView.dequeueReusableCell(withIdentifier: "AyaCell", for: indexPath) as! HomeAyaCell
        cell.selectionStyle = .none
        cell.bind(ayah: ayah, setting: presenter?.setting)
        cell.delegate  = self
        cell.didSelectSection = { [weak self] in
            guard let self = self else { return }
            self.selectAyah(ayah: ayah)
        }
        return cell

    }
  
    func selectAyah(ayah: CAyatModel?) {
        self.hideBasmala()
        self.presenter?.didSelectAyah(ayah: ayah)
        if self.presenter?.openAyatOptions == true {
            self.showCloseWithAnimation(true)
            self.tabBarController?.custom?.hideTabbar()
            showOptionWithAnimation(true)
        }else {
            self.showCloseWithAnimation(false)
            showOptionWithAnimation(false)
            self.tabBarController?.custom?.showTabbar()
        }
        self.vuOptions.currentPlayAyahIndex = nil
        self.vuOptions.selectedAyat = self.presenter?.selectedAyat
        TVAyat.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == ((presenter?.getCountRows(section: indexPath.section) ?? 0)) {
            return 15
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeadView.init(frame: .zero)
        header.titleHeader = presenter?.getTitle(section: section)
        header.cellIsSelected = presenter?.getSelected(section: section)
        header.didSelectSection = { [weak  self] in
            guard let self = self else { return }
            self.hideBasmala()
            self.presenter?.didSelectSection(package: self.presenter?.getSection(section: section))
            if self.presenter?.openAyatOptions == true {
                self.tabBarController?.custom?.hideTabbar()
                self.showOptionWithAnimation(true)
                self.showCloseWithAnimation(true)
            }else {
                self.showCloseWithAnimation(false)
                self.showOptionWithAnimation(false)
                self.tabBarController?.custom?.showTabbar()
            }
            self.vuOptions.currentPlayAyahIndex = nil
            self.vuOptions.selectedAyat = self.presenter?.selectedAyat
            tableView.reloadData()
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 100
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ayah = presenter?.getAyah(section: indexPath.section, row: (indexPath.row))
        self.selectAyah(ayah: ayah)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if canHideBasmala {
            hideBasmala()
        }
        let middleTable = TVAyat.frame.height / 2
        let y = self.TVAyat.contentOffset.y + middleTable
        let x = self.TVAyat.center.x
        let buttonPosition:CGPoint = CGPoint.init(x: x, y: y)
        if let indexPath = TVAyat.indexPathForRow(at: buttonPosition) {
            if let cell = TVAyat.cellForRow(at: indexPath) as? HomeAyaCell {
                let ayah = self.presenter?.getAyah(section: indexPath.section, row: indexPath.row)
                UserDefaultClass.setValue("CurrentAyahInHomeID", ayah?.id)
            }
        }
    }
}
