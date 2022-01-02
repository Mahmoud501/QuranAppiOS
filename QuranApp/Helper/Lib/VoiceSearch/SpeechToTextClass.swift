//
//  SpeechToTextClass.swift
//  VoiceTest
//
//  Created by MAJED A  ALGARNI on 10/21/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import Speech
import AVKit

class DSpeechRecognition: NSObject {
    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Variables
    //------------------------------------------------------------------------------

    private let speechRecognizer        : SFSpeechRecognizer?
    private var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask         : SFSpeechRecognitionTask?
    private var audioEngine             = AVAudioEngine()
    var isAvailable: Bool = false
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- init
    //------------------------------------------------------------------------------

    init(local: String) {
        speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: local))
    }
    
    //------------------------------------------------------------------------------
     // MARK:-
     // MARK:- Custom Methods
     //------------------------------------------------------------------------------

    func setupSpeech() {
         self.isAvailable = false
         self.speechRecognizer?.delegate = self

         SFSpeechRecognizer.requestAuthorization { (authStatus) in

             var isButtonEnabled = false

             switch authStatus {
             case .authorized:
                 isButtonEnabled = true

             case .denied:
                 isButtonEnabled = false
                 print("User denied access to speech recognition")

             case .restricted:
                 isButtonEnabled = false
                 print("Speech recognition restricted on this device")

             case .notDetermined:
                 isButtonEnabled = false
                 print("Speech recognition not yet authorized")
             @unknown default:
                break
            }

             OperationQueue.main.addOperation() {
                 self.isAvailable = isButtonEnabled
             }
         }
     }

    func startRecording(fetch: ((String?)->())?)  {
        if isRunning == true {return}
         // Clear all previous session data and cancel task
        self.recognitionRequest = nil
        if recognitionTask != nil {
             recognitionTask?.cancel()
             recognitionTask = nil
         }

         // Create instance of audio session to record voice
         do {
             let session = AVAudioSession.sharedInstance()
            print(session.category)
             try session.setCategory(.playAndRecord, mode: .measurement)
             try session.setActive(true)
         } catch {
             print("audioSession properties weren't set because of an error.")
         }

         self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

         let inputNode = audioEngine.inputNode

         guard let recognitionRequest = recognitionRequest else {
             fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
         }

         recognitionRequest.shouldReportPartialResults = true

         self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

             var isFinal = false

             if result != nil {
                DispatchQueue.main.async {
                    fetch?(result?.bestTranscription.formattedString)
                    isFinal = (result?.isFinal)!
                }
                 
             }

             if error != nil || isFinal {

                 self.audioEngine.stop()
                self.audioEngine.reset()
                 inputNode.removeTap(onBus: 0)
                self.recognitionTask?.cancel()
                self.recognitionRequest?.endAudio()

                 self.recognitionRequest = nil
                 self.recognitionTask = nil

                 self.isAvailable = true
             }
         })

         let recordingFormat = inputNode.outputFormat(forBus: 0)
         inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
             self.recognitionRequest?.append(buffer)
         }

         self.audioEngine.prepare()

         do {
             try self.audioEngine.start()
         } catch {
             print("audioEngine couldn't start because of an error.")
         }

     }
     
    func stopRecording() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        recognitionTask?.cancel()
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        self.audioEngine.reset()
        self.isAvailable = false
    }

    
    //------------------------------------------------------------------------------
    // MARK:-
    // MARK:- Utiltiy
    //------------------------------------------------------------------------------

    var isRunning: Bool {
        get {
            return audioEngine.isRunning
        }
    }

}


//------------------------------------------------------------------------------
// MARK:-
// MARK:- SFSpeechRecognizerDelegate Methods
//------------------------------------------------------------------------------

extension DSpeechRecognition: SFSpeechRecognizerDelegate {        

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.isAvailable = true
        } else {
            self.isAvailable = false
        }
    }
}
