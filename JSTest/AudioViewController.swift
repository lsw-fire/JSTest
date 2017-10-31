//
//  AudioViewController.swift
//  JSTest
//
//  Created by Li Shi Wei on 27/10/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit
import AVFoundation
import CoreAudio

class AudioViewController: UIViewController {
    
    var recorder: AVAudioRecorder!
    var leverTimer = Timer()
    
    let Level_threshold : Float = -10.0

    override func viewDidLoad() {
        super.viewDidLoad()

        let documents = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])
        
        let url = documents.appendingPathComponent("record.caf")
        
        let recordSettings: [String:Any] = [
            AVFormatIDKey: kAudioFormatAppleIMA4,
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:2,
            AVEncoderBitRateKey:12800,
            AVLinearPCMBitDepthKey:16,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
            try recorder = AVAudioRecorder(url:url,settings:recordSettings)
        }catch{
            return
        }
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
        recorder.record()
        
        leverTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func levelTimerCallback() {
        recorder.updateMeters()
        
        let level = recorder.averagePower(forChannel: 0)
        let isLoud = level > Level_threshold;
        print(level)
    }
    
}
