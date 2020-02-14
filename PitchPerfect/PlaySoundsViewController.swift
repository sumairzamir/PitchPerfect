//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Sumair Zamir on 26/01/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: - IBOutlets
    // Code to define the UI buttons
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    // MARK: - IBOutlet collection
    @IBOutlet var allButtons: [UIButton]!
    
    // MARK: - AVFoundation variables
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: - Tag definitions
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: - Switch method for buttons
    // Method defines adjustment to sound for each button. Cases based on enum above.
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // MARK: - Stop button logic
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    // MARK: - Logic for the audio file
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        // A for loop to set the correct aspect ratio for the images in the UI buttons.
        for button in allButtons {
            button.contentMode = .center
            button.imageView?.contentMode = .scaleAspectFit
        }
        
        // MARK: - Deselect the stop button
        // Ask Aiman override/vs standard method
        
        func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            configureUI(.notPlaying)
            
        }
        
    }
    
}
