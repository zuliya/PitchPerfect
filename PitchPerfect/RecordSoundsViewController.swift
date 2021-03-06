//
//  RecordSoundsViewController
//  PitchPerfect
//
//  Created by Zulia on 13/08/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit
import AVFoundation



class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!

    
    //   appears before Will
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    }
    
    func configureUI(isRecording: Bool) {
        // TODO: - based on parameter value, add code for enabling and disabling
        // the recording and stop buttons, and setting the label text
        
        if isRecording
        {
            recordingLabel.text = "Recording in progress"
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }
        else
        {
            recordButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to Record"
        }
        
    }

    
    @IBAction func recordAudio(_ sender: UIButton) {

        configureUI(isRecording: true)
   
        // path is being passed as a string (.wav)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // taking care of Stop recording
    @IBAction func stopRecording(_ sender: AnyObject) {

        configureUI(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    

func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    }
    else{
        print("recording was not succesful")
    }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}

