//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Daria on 09.05.2022.
//

import UIKit
import AVFoundation

enum AudioType {
    case original
    case mlaudio
}

class DetailAudioViewController: UIViewController {
    @IBOutlet weak var audioImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationProgressView: UIProgressView!
    
    var audioPlayer: AVAudioPlayer?
    
    var audioName: String?
    var time: Int = 0
    var timer: Timer?
    var audioType: AudioType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioImageView.image = UIImage(named: audioName ?? "")
        audioImageView.layer.cornerRadius = 8
        
        durationLabel.text = "00:00"
        durationProgressView.progress = 0.0
    }
    
    private func handlePlay(_ url: URL) {
        if audioPlayer?.isPlaying ?? false {
            audioPlayer?.stop()
        }
        
        setTimer()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    @IBAction func originalAudioButtonTapped(_ sender: Any) {
        if audioType == .original {
            audioType = nil
            audioPlayer?.stop()
            timer?.invalidate()
            return
        }
        
        guard let audioName = audioName else {
            return
        }
        
        guard let pathToSound = Bundle.main.path(forResource: audioName, ofType: "wav") else {
            return
        }
        
        audioType = .original
        
        let audioURL = URL(fileURLWithPath: pathToSound)
        
        handlePlay(audioURL)
    }
    
    @IBAction func mlAudioButtonTapped(_ sender: Any) {
        if audioType == .mlaudio {
            audioType = nil
            audioPlayer?.stop()
            timer?.invalidate()
            return
        }
        
        guard let urlOfMLAudio = MLModelManager.sharedManager.url else {
            return
        }
        
        audioType = .mlaudio
        
        handlePlay(urlOfMLAudio)
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        audioPlayer?.stop()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTimer() {
        timer?.invalidate()
        time = 0
        durationLabel.text = "00:00"
        durationProgressView.progress = 0.0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    @objc func startTimer() {
        time += 1
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.durationLabel.text = self.time < 10 ? "00:0\(self.time)" : "00:\(self.time)"
                self.durationProgressView.progress += 1 / 15
            })
        }
        
        if time == 15 {
            timer?.invalidate()
        }
    }
}

