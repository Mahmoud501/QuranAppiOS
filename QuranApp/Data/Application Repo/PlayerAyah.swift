//
//  PlayerAyah.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CustomPlayerItem:  AVPlayerItem{
    
    var nextAyah: CAyatModel?
    
    var ayah: CAyatModel?
    
    var isLast: Bool?
    
    var isRepeat: Bool? = true
    
    
}


class PlayerAyat {
    
    deinit {
        print("deinit Player Ayat")
    }
    
    private var player: AVQueuePlayer = AVQueuePlayer()
    private var reciterManger = ReciterManger()
    private var isplay: Bool = false
    private var isHold = false
    private var isDownloaded = false
    private var isDownloading = false
    private var isFinishPlay = false
    
    
    var didFinishPlayAyah: ((CAyatModel?, Bool?)->())?
    var downloadProcess: ((Int, Int) -> ())?
    var downloadFail: ((String)->())?
    var willStartPlay: ((Int)->())?
    var isPlaying: Bool  {
        get {
            return isplay
        }
    }
    var isDownloaedAyat: Bool  {
        get {
            return isDownloaded
        }
    }
    
    var isDownloadingAyat: Bool  {
        get {
            return isDownloading
        }
    }
    
    var isFinishPlayAyat: Bool  {
        get {
            return isFinishPlay
        }
    }
    
    
    private var setting: CSetting? {
        get {
            
            let settingRepo = CoreDataRepository<CSetting>.init()
            return settingRepo.getAll()?.first
        }
    }

    func resetParamerter() {
        isDownloaded = false
        isplay = false
        isFinishPlay = false
        isHold = false
        if self.isDownloading == true {
            self.cancelDownload()
        }else {
            self.isDownloading = false
        }
        player.pause()
        player.removeAllItems()
    }
    
    func genralPlay(ayat: [CAyatModel]?, index: Int? = nil) {
        resetParamerter()
        if (ayat?.count ?? 0) <= 0 { return }
        if let reciter = AppFactory.currentReciter {
            self.isDownloading = true
            UserDefaultClass.setValue("GeneralAyatDown", nil)
            reciterManger.downloadAyat(indentifer: "GeneralAyatDown", reciter: reciter, ayat: ayat!, process: { (current, total) in
                DispatchQueue.main.async {
                    self.downloadProcess?(current, total)
                }
                if current == (total) {
                    self.isDownloading = false
                    self.isDownloaded = true
                    DispatchQueue.main.async {
                        self.willStartPlay?(index ?? 0)
                        self.play(ayat: ayat)
                    }
                }
            }) { (error) in
                self.isDownloading = false
                DispatchQueue.main.async {
                    self.downloadFail?(error)
                }
            }
        }
        
    }
    
    func play(ayat: [CAyatModel]?) {
        if (ayat?.count ?? 0) <= 0 { return }
        self.isFinishPlay = false
        player.removeAllItems()
        var repeat_count = Int(setting?.ayah_repeat ?? 0)
        repeat_count = repeat_count <= 0 ? 1 : repeat_count
        var arrItem = [CustomPlayerItem]()
        let reciter = AppFactory.currentReciter
        let reciter_id = reciter?.id ?? "0"
        let reciter_type = reciter?.type.description ?? ""
        var ayahIndex = 0
        for item in ayat ?? [] {
            for i in 0 ..< repeat_count {
                let sid = Int(item.surha?.id ?? "0")!
                let surhaNum = String(format: "%.3i",  sid)
                let id = Int(item.sort)
                let ayahNum = String(format: "%.3i",  id)
                let path = "\(reciter_id)_\(reciter_type)_\(surhaNum)\(ayahNum).mp3"
                let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(path)
                let itemPlay = CustomPlayerItem(url:  cacheURL!)
                itemPlay.isRepeat = i == (repeat_count - 1) ? false : true
                itemPlay.ayah = item
                itemPlay.isLast = item == (ayat!.last) ? true : false
                if itemPlay.isLast == true {
                    itemPlay.nextAyah = nil
                }else {
                    itemPlay.nextAyah = ayat?[ayahIndex + 1]
                }
                
                arrItem.append(itemPlay)
            }
            ayahIndex += 1
        }
        player.replaceCurrentItem(with: arrItem[0])
        for i in 1 ..< arrItem.count {
            player.insert(arrItem[i], after: arrItem[i - 1])
        }
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.advance        
    
        let selector = #selector(PlayerAyat.playerItemDidReachEnd(notification:))
        let name = NSNotification.Name.AVPlayerItemDidPlayToEndTime
        // removing old observer and adding it again for sequential calls.
        // Might not be necessary, but I like to unregister old notifications.
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .allowAirPlay])
            print("Playback OK")
            try AVAudioSession.sharedInstance().setActive(true)
            print("Session is Active")
        } catch {
            print(error)
        }

        
        play()
        
    }
    
    
    func cancelDownload() {
        self.isDownloading = false
        UserDefaultClass.setValue("GeneralAyatDown", true)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification)
    {
        if let item = self.player.currentItem as? CustomPlayerItem {
                           
            if item.isRepeat == false {
            
                print("ooo")
                
                if item.isLast == true {
                
                    self.isplay = false
                    
                }
                
                self.isFinishPlay = item.isLast ?? false
                DispatchQueue.main.async {
                    self.didFinishPlayAyah?(item.ayah, item.isLast)
                }
                
                var delay_time = Int(self.setting?.ayah_delay ?? 0)
                
               
                let current_id = Int(item.ayah?.id ?? "0") ?? 0
                if let next_id = Int(item.nextAyah?.id ?? "") {
                    if (current_id + 1 ) != next_id {
                        if delay_time < 3 {
                            delay_time = 3
                            print("delay_time")
                        }
                    }
                }
                
                if delay_time > 0 {
                    self.hold()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(delay_time)) {
                
                    self.isHold = false
                    
                    if (self.isplay == true) {
                    
                        self.play()
                        
                    }
                    
                }
                
            }
            
        }
       
    }

    
    func cancelPlayer() {
        player.pause()
        player.removeAllItems()
    }
    
    func hold() {
        self.isHold = true
        self.isplay = true
        self.player.pause()
    }
    
    func play() {
        self.isplay = true
        if isHold == false {
            self.player.play()
        }else {
            print("Holding now & will playing...")
        }
    }
    
    func pause() {
        self.player.pause()
        self.isplay = false
    }
    
    func seekTo(index: Int, ayat: [CAyatModel]?, withDown: Bool? = nil) {
        if let ayat = ayat {
            let myAyat = ayat[index ..< (ayat.count)]
             self.cancelDownload()                   
            let time: TimeInterval = withDown == true ? 1 : 0
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.cancelPlayer()
                if withDown == true {
                    self.resetParamerter()
                    self.genralPlay(ayat: Array(myAyat), index: index)
                }else {
                    self.play(ayat: Array(myAyat))
                }
            }
        }        
    }
    
    func scrollToAyah(ayah: CAyatModel?) {
        
    }
    
    
}
