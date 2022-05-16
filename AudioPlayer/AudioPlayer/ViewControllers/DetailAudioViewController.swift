//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daria on 09.05.2022.
//

import UIKit
import AVFoundation

class DetailAudioViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    var name: String?
    
    @IBOutlet var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Button.setTitle("Car Sound", for: .normal)
        let soundImage = UIImage(named: "sound_picture.png")
        Button.setImage(soundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        MLModelManager.sharedManager.enhanceAudio("cafe")
    }
    
    @IBAction func buttonClicked( sender: Any) {
    
        let pathToSound = Bundle.main.path(forResource: "cafe", ofType: "wav")!
        guard let url = MLModelManager.sharedManager.url else {
            print("error")
            return
        }
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        catch
        {
            print(error)
        }
        
        }

}

