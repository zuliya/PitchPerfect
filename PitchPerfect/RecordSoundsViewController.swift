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

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    //   appears before Will
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    //appears After
    
    override func viewWillAppear(_ animated: Bool) {
        
    // Not sure why super class is being used here
    //!!! * (look at the documentation )
        
    super.viewWillAppear(animated)
        print("View will appear is being called")
    }

    @IBAction func recordAudio(_ sender: AnyObject)
    {
        recordingLabel.text = "Recording in progress"
        // Can only press stop / not record
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        // path is being passed as a string (.wav)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        // had to changed from original as ANY (not sure why Xcode didnt allow otherwise)
        print(filePath as Any)
        
        
       // loads of try and cath
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // taking care of Stop recording
    @IBAction func stopRecording(_ sender: Any) {
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }

}

func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    print("finished recording")
}

