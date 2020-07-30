//
//  PlaySoundsViewController.swift
//  Pick Your Pitch
//
//  Created by JON DEMAAGD on 7/4/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: - PlaySoundsViewController: UIViewController

class PlaySoundsViewController: UIViewController {

    // MARK: Properties
    
    let SliderValueKey = "Slider Value Key"
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    // MARK: Outlets
    
    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: receivedAudio.filePathUrl as URL)
        } catch _ {
            audioPlayer = nil
        }
        audioPlayer.enableRate = true

        audioEngine = AVAudioEngine()
        do {
            audioFile = try AVAudioFile(forReading: receivedAudio.filePathUrl as URL)
        } catch _ {
            audioFile = nil
        }

        sliderView.value = UserDefaults.standard.float(forKey: SliderValueKey)

        setUserInterfaceToPlayMode(false)
    }
    
    // MARK: Set Interface
    
    func setUserInterfaceToPlayMode(_ isPlayMode: Bool) {
        startButton.isHidden = isPlayMode
        stopButton.isHidden = !isPlayMode
        sliderView.isEnabled = !isPlayMode
    }

    // MARK: Actions
    
    @IBAction func playAudio(_ sender: UIButton) {
        let pitch = sliderView.value
        playAudioWithVariablePitch(pitch)
        setUserInterfaceToPlayMode(true)

        UserDefaults.standard.set(sliderView.value, forKey: SliderValueKey)
    }
    
    @IBAction func stopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func sliderDidMove(_ sender: UISlider) {
        print("Slider value: \(sliderView.value)")
    }
    
    // MARK: Play Audio
    
    func playAudioWithVariablePitch(_ pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attach(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            // When the audio completes, set the user interface on the main thread
            DispatchQueue.main.async {
                self.setUserInterfaceToPlayMode(false)
            }
        }
        
        do {
            try audioEngine.start()
        } catch _ {
            
        }
        
        audioPlayerNode.play()
    }
}
