//
//  RecordClass.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/8/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import AVFoundation
import Accelerate

class RecordClass {
    
    var timerTracker: Timer!
    let audioEngine = AVAudioEngine()
    var renderTs: Double = 0
    var recordingTs: Double = 0
    var silenceTs: Double = 0
    var audioFile: AVAudioFile?
    var audioFileForUpload: AVAudioFile?
    var audioURL:URL!
    var type = "2"
    let settings = [AVFormatIDKey: kAudioFormatLinearPCM ] as [String : Any]
    var audioPlayer: AVAudioPlayer?

    
        // MARK:- Recording
        func startRecording() {
//            if let d = self.delegate {
//                d.didStartRecording()
//            }
//
            print(AVAudioSession.sharedInstance().sampleRate)
        renderTs = 0
        recordingTs = 0
        silenceTs = 0
        self.audioURL = nil
        self.audioFile = nil
        self.audioFileForUpload = nil
        self.audioPlayer = nil
        self.recordingTs = NSDate().timeIntervalSince1970
        self.silenceTs = 0
            
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .measurement)
            try session.setActive(true)
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }
        
        let inputNode = self.audioEngine.inputNode
            
        guard let format = self.format() else {
            return
        }
        
            var ff = inputNode.inputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: ff) { (buffer, time) in
//            let level: Float = -50
//            let length: UInt32 = 1024
//            buffer.frameLength = length
//            let channels = UnsafeBufferPointer(start: buffer.floatChannelData, count: Int(buffer.format.channelCount))
//            var value: Float = 0
//            vDSP_meamgv(channels[0], 1, &value, vDSP_Length(length))
//            var average: Float = ((value == 0) ? -100 : 20.0 * log10f(value))
//            if average > 0 {
//                average = 0
//            } else if average < -100 {
//                average = -100
//            }
//            let silent = average < level
//            let ts = NSDate().timeIntervalSince1970
//            if ts - self.renderTs > 0.1 {
//                let floats = UnsafeBufferPointer(start: channels[0], count: Int(buffer.frameLength))
//                let frame = floats.map({ (f) -> Int in
//                    return Int(f * Float(Int16.max))
//                })
//                DispatchQueue.main.async {
////                    let seconds = (ts - self.recordingTs)
////                    self.timeLabel.text = seconds.toTimeString
//                    self.renderTs = ts
////                    let len = self.vuRecordVisual.waveforms.count
////                    for i in 0 ..< len {
////                        let idx = ((frame.count - 1) * i) / len
////                        let f: Float = sqrt(1.5 * abs(Float(frame[idx])) / Float(Int16.max))
////                        self.vuRecordVisual.waveforms[i] = min(49, Int(f * 50))
////                    }
//                    //self.vuRecordVisual.active = !silent
//                    //self.vuRecordVisual.setNeedsDisplay()
//                }
//            }
//
            let write = true
            if write {
                if self.audioFile == nil {
                    self.audioFile = self.createAudioRecordFile()
                }
                if let f = self.audioFile {
                    do {
                        try f.write(from: buffer)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                
                if self.audioFileForUpload == nil {
                    self.audioFileForUpload = self.createAudioRecordFileForUpload()
                }
                if let f = self.audioFileForUpload {
                    do {
                        try f.write(from: buffer)
                        //self.viewModel.voiceData = try Data(contentsOf: f.url)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        do {

            self.audioEngine.prepare()
            try self.audioEngine.start()
        } catch let error as NSError {
            print(error.localizedDescription)
            return
        }
//        self.updateUI(.recording)
    }
        
        func stopRecording() {
//            if let d = self.delegate {
//                d.didFinishRecording()
//            }
        
       // self.audioFile = nil
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.audioEngine.stop()
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(false)
        } catch  let error as NSError {
            print(error.localizedDescription)
            return
        }
//        self.updateUI(.stopped)
    }
        
         func checkPermissionAndRecord() {
            let permission = AVAudioSession.sharedInstance().recordPermission
            switch permission {
            case .undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission({ (result) in
                    DispatchQueue.main.async {
                        if result {
                            self.audioFile = nil
                            self.audioFileForUpload = nil
                            self.startRecording()
                        }
                        else {
    //                        self.updateUI(.denied)
                        }
                    }
                })
                break
            case .granted:
                self.audioFile = nil
                self.audioFileForUpload = nil
                self.startRecording()
                break
            case .denied:
    //            self.updateUI(.denied)
                break
            @unknown default:
                break
            }
        }
        
         func isRecording() -> Bool {
            if self.audioEngine.isRunning {
                return true
            }
            return false
        }
        
         func format() -> AVAudioFormat? {
            
            let format = AVAudioFormat(settings: self.settings)
            return format
        }
        
        // MARK:- Paths and files
         func createAudioRecordPath() -> URL? {
            let format = DateFormatter()
            format.dateFormat="yyyy-MM-dd-HH-mm-ss-SSS"
            let currentFileName = "recording-\(format.string(from: Date()))" + ".caf"
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = documentsDirectory.appendingPathComponent(currentFileName)
            
            let currentFileNameForUpload = "recording-\(format.string(from: Date()))" + ".wav"
            let documentsDirectoryForUpload = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let urlForUpload = documentsDirectoryForUpload.appendingPathComponent(currentFileNameForUpload)
            self.audioURL = nil
            self.audioURL = urlForUpload
            
            return url
        }
        
         func createAudioRecordFile() -> AVAudioFile? {
            guard let path = self.createAudioRecordPath() else {
                return nil
            }
            do {
                let file = try AVAudioFile(forWriting: path, settings: self.settings, commonFormat: .pcmFormatFloat32, interleaved: true)
                return file
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        
         func createAudioRecordFileForUpload() -> AVAudioFile? {
            guard let path = self.audioURL else {
                return nil
            }
            do {
                let file = try AVAudioFile(forWriting: path, settings: self.settings, commonFormat: .pcmFormatFloat32, interleaved: true)
                return file
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        
        // MARK:- Playback
         func loadAudio(url: URL) {
//
//            if let d = self.delegate {
//    //            d.didStartPlayback()
//            }
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(.playback, mode: .default)
                try session.setActive(true)
            } catch let error as NSError {
                print(error.localizedDescription)
                return
            }
            do {
                let data = try Data(contentsOf: url)
                self.audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.wav.rawValue)
            } catch let error as NSError {
                print(error.localizedDescription)
                return
            }
            if let player = self.audioPlayer {
                //player.delegate = self
                player.prepareToPlay()
                player.setVolume(100, fadeDuration: 0)

            }
        }
        
        func stopPlay() {
//            if let d = self.delegate {
//    //            d.didFinishPlayback()
//            }
            if let player = self.audioPlayer {
                player.pause()
            }
            do {
                try AVAudioSession.sharedInstance().setActive(false)
            } catch  let error as NSError {
                print(error.localizedDescription)
                return
            }
        }
    
        func PlayRecord() {
               
                do {
                    let session = AVAudioSession.sharedInstance()
                    try session.setCategory(.playback, mode: .default)
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch  let error as NSError {
                    print(error.localizedDescription)
                    return
                }
            if let player = self.audioPlayer {
                player.play()
            }
        }
        
         func isPlaying() -> Bool {
            if let player = self.audioPlayer {
                return player.isPlaying
            }
            return false
        }

    @objc func trackAudio() {
        if let player = audioPlayer {
            let normalizedTime = Float(player.currentTime / player.duration)
            //AudioProgressBar.progress = normalizedTime
            //lblRecordTime.text = TimeInterval(player.duration - player.currentTime).stringFromTimeInterval()
        }
        
    }
    
}

