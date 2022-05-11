//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daria on 09.05.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Button.setTitle("Car Sound", for: .normal)
        let soundImage = UIImage(named: "sound_picture.png")
        Button.setImage(soundImage?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    @IBAction func buttonClicked( sender: Any) {
    
        let pathToSound = Bundle.main.path(forResource: "car", ofType: "wav")!
        let url = URL(fileURLWithPath: pathToSound)
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

