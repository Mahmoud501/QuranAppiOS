//
//  AyaOption+Player.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/18/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension AyaOptionsView {
    
    func playAyat() {
        if self.player.isDownloaedAyat == true {
            if self.player.isPlaying == true {
                self.player.pause()
                self.btnPlay.setImage(UIImage.init(named: "play")!, for: .normal)
                self.lblPlay.text = "Play".localized
            }else {
                if player.isFinishPlayAyat {
                    self.vuPlay.state = .pending
                    self.vuStackPlay.alpha = 0
                    self.player.seekTo(index: 0, ayat: orderAyat, withDown: true)
                    self.btnPlay.setImage(UIImage.init(named: "Pause")!, for: .normal)
                    self.lblPlay.text = "Pause".localized
                    self.willPlayAyah?(self.orderAyat?[0], false)
                    self.currentPlayAyahIndex = 0
                    
                }else {
                    self.player.play()
                    self.btnPlay.setImage(UIImage.init(named: "Pause")!, for: .normal)
                    self.lblPlay.text = "Pause".localized
                }
                
            }
        }else {
            if self.player.isDownloadingAyat == true {
                self.player.cancelDownload()
                self.vuStackPlay.alpha = 1
                self.vuPlay.state = .startDownload
                self.btnPlay.setImage(UIImage.init(named: "play")!, for: .normal)
                self.lblPlay.text = "Play".localized
            }else {
                self.myStepSlider.isUserInteractionEnabled = false
                self.vuPlay.state = .pending
                self.vuStackPlay.alpha = 0
                self.player.genralPlay(ayat: orderAyat)
            }
        }               
    }
    
    func setupPlayer() {
        
        self.player.downloadProcess = { [weak self] (current, total) in
            DispatchQueue.main.async {
            guard let self = self else { return }
            if current == (total) {
                self.vuPlay.state = .startDownload
                self.myStepSlider.isUserInteractionEnabled = true
                UIView.animate(withDuration: 0.5) {
                    self.vuStackPlay.alpha = 1
                }
            }else {
                self.vuStackPlay.alpha = 0
                self.vuPlay.state = .downloading
                let precent = (CGFloat((current )) / CGFloat((total)))
                self.vuPlay.stopDownloadButton.progress = precent
            }
            }
        }
        
        self.player.downloadFail = {  [weak self] (err) in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.vuStackPlay.alpha = 1
            self.vuPlay.state = .startDownload
            self.myStepSlider.isUserInteractionEnabled = true
            }
        }
        
        self.player.didFinishPlayAyah = {  [weak self] (ayah, isLast) in
            guard let self = self else { return }
            DispatchQueue.main.async {
            if isLast == true {
                self.btnPlay.setImage(UIImage.init(named: "play")!, for: .normal)
                self.lblPlay.text = "Play".localized
                self.currentPlayAyahIndex = nil
            }else {
                let index = self.orderAyat?.firstIndex(of: ayah!)
                self.blockStepper = true
                self.myStepSlider.index = (UInt(index ?? 0)) + 1
                self.blockStepper = false
                let nextAyah = (index ?? 0) + 1
                if nextAyah < (self.orderAyat?.count ?? 0) {
                    self.willPlayAyah?(self.orderAyat?[nextAyah], true)
                    self.currentPlayAyahIndex = nextAyah
                }
            }
            }
        }
        
        self.player.willStartPlay = { [weak self] (index)  in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.myStepSlider.isUserInteractionEnabled = true
            self.btnPlay.setImage(UIImage.init(named: "Pause")!, for: .normal)
            self.lblPlay.text = "Pause".localized
            self.blockStepper = true
            self.myStepSlider.index = UInt(index)
            self.blockStepper = false
            self.willPlayAyah?(self.orderAyat?[index],false)
            self.currentPlayAyahIndex = index
            }
        }
        
    }
    
    
    
}
