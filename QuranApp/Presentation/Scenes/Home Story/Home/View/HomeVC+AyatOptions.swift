//
//  HomeVC+AyatOptions.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/20/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit


extension HomeVC {
    
    
    
    func setupAyatOptions() {
        
        self.vuOptions.willPlayAyah = { [weak self](ayah, animation) in
            guard let self = self else { return }
            self.scrollToAyah(ayah: ayah, animation: animation)
        }
        
        self.vuOptions.colorAyat = { [weak self] in
            guard let self = self else { return }
            self.TVAyat.reloadData()
        }
        
        self.vuOptions.memorizedAyat = { [weak self] in
            guard let self = self else { return }
            self.TVAyat.reloadData()
        }
        self.vuOptions.scrollToAyah = { [weak self] scrollAyah in
            guard let self = self else { return }
            self.scrollToAyah(ayah: scrollAyah, animation: true)

        }
        
    }
    
    func scrollToAyah (ayah: CAyatModel?, animation: Bool? = nil, finish: ((IndexPath)->())? = nil) {
        let tuple = self.presenter?.getIndexPathOf(ayah: ayah) //tuple -> section , row
        if let tuple = tuple {
            if tuple.0 == nil { return }
            if self.presenter?.scrollDirect == "0" {
                
                self.TVAyat.scrollToRow(at: IndexPath.init(row: tuple.1!, section: tuple.0!), at: UITableView.ScrollPosition.middle, animated: animation ?? false)
            }else if self.presenter?.scrollDirect == "1" {
                self.TVAyat.scrollToRow(at: IndexPath.init(row: tuple.1!, section: tuple.0!), at: UITableView.ScrollPosition.top, animated: animation ?? false)
            }else {
                self.TVAyat.scrollToRow(at: IndexPath.init(row: tuple.1!, section: tuple.0!), at: UITableView.ScrollPosition.none, animated: animation ?? false)
            }
            let time: TimeInterval = (animation ?? false) == false ? 0.001 : 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                finish?(IndexPath.init(row: tuple.1!, section: tuple.0!))
            }
        }
    }
    
   
    
    
}
