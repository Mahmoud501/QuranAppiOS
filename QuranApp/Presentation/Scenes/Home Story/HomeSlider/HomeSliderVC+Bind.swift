//
//  HomeSliderVC+Bind.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/13/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension HomeSliderVC {
    
    func refreehTable() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            self.presenter.refresh { [weak self] in
                guard let self = self else { return }
                self.TVContainer.reloadData()
            }
        })
    }
    
    func bind() {
        self.bindReciter()
        self.bindSetting()
    }
    
    func bindReciter() {
        let reciter = presenter.currentReciter
        let image = reciter?.image_path ?? ""
        self.ImgReciter.image = UIImage.init(named: image)
        if (reciter?.type ?? 0) == ReciterType.Murattal.rawValue {
            self.lblType.text = "Murattal".localized
        }else if (reciter?.type ?? 0) == ReciterType.Mujawad.rawValue {
            self.lblType.text = "Mujawad".localized
        }else if (reciter?.type ?? 0) == ReciterType.Muallim.rawValue {
            self.lblType.text = "Muallim".localized
        }else if (reciter?.type ?? 0) == ReciterType.Translate.rawValue {
            self.lblType.text = "Translate".localized
        }
        if AppFactory.isArabic == true {
            self.lblName.text = reciter?.name_ar
        }else {
            self.lblName.text = reciter?.name_en
        }
    }
    
    func bindSetting() {
        self.vuBadgeRepeat.badgeString = presenter.numberOFRepeat
        self.vuBadgeInterval.badgeString = presenter.delayTime
        
    }
    
    func download(surhas: [CSurha]) {
        
        for item in surhas {
            let surha = item
            let row = (Int(surha.id ?? "0") ?? 0) - 1
            if let reciter = presenter.currentReciter {
                if presenter.isSurhaDownloaded(reciter: reciter, surha: surha) == false {
                    let indexPath = IndexPath.init(row: row, section: 0)
                    if  (presenter.isDownloaded[row].status ?? 0 ) == 0  {
                        presenter.isDownloaded[row].status = 1
                        TVContainer.reloadRows(at: [indexPath], with: .none)
                        presenter.downloadSurha(surha: surha, for: indexPath.row) {[weak self] (row) in
                            guard let self = self else { return }
                            if let cell = self.TVContainer.cellForRow(at: indexPath) as? DownloadCell {
                                cell.download = self.presenter.isDownloaded[row]
                            }
                        }
                    }else if presenter.isDownloaded[indexPath.row].status == 2 {
                        presenter.cancelDownload(surha: surha)
                        if let cell = self.TVContainer.cellForRow(at: indexPath) as? DownloadCell {
                            cell.download = self.presenter.isDownloaded[indexPath.row]
                        }
                    }
                }
            }
            
        }
        
    }
    
    func cancelAll() {
        for item in presenter.surhas ?? [] {
            presenter.cancelDownload(surha: item)
        }
        self.TVContainer.reloadData()
    }
    
}
