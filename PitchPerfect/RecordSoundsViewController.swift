//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Sumair Zamir on 25/01/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: - IBOutlets
    // The code above links the UI elements to the application code below
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: - View methods
    
    // Even before the view is shown, the UI has been configured in the not recording state.
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(false)
    }
    
    // MARK: - configureUI vRecordSounds
    // Much simpler code. Just define a Bool, and the states below. Call the function with true and false where needed.
    
    func configureUI(_ isRecording:Bool = false) {
        recordingLabel.text = isRecording ? "Recording in progress":"Tap to record"
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    
    // Switch method - not needed when just doing a true/false, i.e. BOOL
    // Step1: Define an enumeration for the two cases
    
    //    enum RecordingState {case recording, notRecording}
    //
    //    // Step2: Define a method based on a switch condition
    //
    //    func configureUI (_ recordState: RecordingState) {
    //        switch(recordState) {
    //        case .recording:
    //            stopRecordingButton.isEnabled = true
    //            recordButton.isEnabled = false
    //            recordingLabel.text = "Recording in progress"
    //        case .notRecording:
    //            stopRecordingButton.isEnabled = false
    //            recordButton.isEnabled = true
    //            recordingLabel.text = "Tap to record"
    //        }
    //    }
    //
    // MARK: - IBAction
    // The code below works on keypress. To test whether the code is working type a print function. This is called caveman debugging.
    @IBAction func recordAudio(_ sender: Any) {
        // The following code calls the method to configure the UI in the recording state on button press.
        configureUI(true)
        
        // The following code calls on the AVFoundation framework, to specify a file name, path and initiate the recording
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        // The delegate protocol is defined below to ensure adherence.
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        // The following code calls the method to configure the UI in to the non-recording state on button press.
        configureUI(false)
        
        // The following code stops the recording of the file.
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Segue logic
    // The following method is called from the Delegate protocol. It's logic considers whether the audio has successfully recorded and returns a Bool. On true it proceeds to the next view controller.
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Guard statement to move onto the next view controller. Swift preferred method.
        // Adds an alert when the recording fails. 
        guard flag else {
            print("Recording was not successful")
            let alert = UIAlertController(title: "Error", message: "Recording was not successful", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        
        // If statement form for moving onto the next view controller.
        //        if flag {
        //        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        //        }   else {
        //            print("Recording was not successful")
        //        }
    }
    
    // MARK: - Segue audio logic
    // The following code allows the audio file to be used by the PlaySoundsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}
