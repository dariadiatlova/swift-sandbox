//
//  SongTableViewCell.swift
//  AudioPlayer
//
//  Created by Daria on 15.05.2022.
//

import Foundation
import UIKit

class SongTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameSongLabel: UILabel!
    @IBOutlet weak var songPhotoImageView: UIImageView!
    
    func setCell(name: String) {
        nameSongLabel.text = name
        songPhotoImageView.image = UIImage(named: name)
    }
    
}
