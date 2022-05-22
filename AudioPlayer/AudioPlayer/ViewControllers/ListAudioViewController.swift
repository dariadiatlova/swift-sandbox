//
//  ListAudioViewController.swift
//  AudioPlayer
//
//  Created by Daria on 16.05.2022.
//

import Foundation
import MKGradientView
import UIKit

class ListAudioViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        let backgroundView = GradientView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        backgroundView.type = .linear
//        backgroundView.colors = [UIColor.cyan, UIColor.darkGray]
//        backgroundView.locations = [0, 1]
//        backgroundView.startPoint = CGPoint(x: 0.0, y: 0.0)
//        backgroundView.endPoint = CGPoint(x: 1.0, y: 1.0)
//        tableView.backgroundView = backgroundView
        
        showAboutApp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    private func showAboutApp() {
        let vc = UIAlertController(title: "Инструкция", message: "Выбирите одну из аудиоозаписей в нашей библиотеке \u{1F917}", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Понятно!", style: .cancel))
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ListAudioViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants().listOfAudio.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        cell.setCell(name: Constants().listOfAudio[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let audioName = Constants().listOfAudio[indexPath.row]
        if MLModelManager.sharedManager.enhanceAudio(audioName) {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailAudioViewController") as! DetailAudioViewController
            vc.audioName = audioName
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("error")
        }
    }
}
