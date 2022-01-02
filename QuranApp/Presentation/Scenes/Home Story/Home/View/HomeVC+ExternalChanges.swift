//
//  HomeVC+ExternalChanges.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension HomeVC {
    
    func didChangeTafseer() {
        presenter?.getHome { [weak self] in
            self?.TVAyat.reloadData()
        }
    }
        
    func didChangeReciter() {
        let image = presenter?.reciter?.image_path ?? ""
        self.ImgReciter.image = UIImage.init(named: image)
    }
    
    func changeQuranCategory(to: String) {
        presenter?.resetData()
        self.TVAyat.reloadData()        
        presenter?.changeQuranType(to: to)
        presenter?.getHome { [weak self] in
            guard let self = self else { return }
            self.TVAyat.reloadData()
            self.TVAyat.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableView.ScrollPosition.none, animated: false)
        }
    }
    
    
    func changeQuranSetting(setting: CSetting?) {
        self.presenter?.setting = setting        
        self.presenter?.scrollDirect = setting?.ayatScrollDirection
        self.presenter?.isSingleSelection = setting?.isSingleSelection
        self.TVAyat.reloadData()
    }
    
    func search(ayah: CAyatModel?) {
        self.scrollToAyah(ayah: ayah, animation: true) { [weak self] (indexPath) in
            guard let self = self else { return }
            if let cell = self.TVAyat.cellForRow(at: indexPath) {
                let cellColor = cell.backgroundColor
                cell.backgroundColor = .yellow
                UIView.animate(withDuration: 3) {
                    cell.backgroundColor = cellColor
                }
            }
        }
    }
    
}
