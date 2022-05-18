//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daria on 09.05.2022.
//

import UIKit
import AVFoundation

class DetailAudioViewController: UIViewController {
    @IBOutlet weak var audioImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationProgressView: UIProgressView!
    
    var audioPlayer: AVAudioPlayer?
    
    var audioName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioImageView.image = UIImage(named: audioName ?? "")
    }
    
    private func handlePlay(_ url: URL) {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    @IBAction func originalAudioButtonTapped(_ sender: Any) {
        guard let pathToSound = Bundle.main.path(forResource: "cafe", ofType: "wav") else {
            return
        }
        
        let audioURL = URL(fileURLWithPath: pathToSound)
        
        handlePlay(audioURL)
    }
    
    @IBAction func mlAudioButtonTapped(_ sender: Any) {
        guard let urlOfMLAudio = MLModelManager.sharedManager.url else {
            print("error")
            return
        }
        
        handlePlay(urlOfMLAudio)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

