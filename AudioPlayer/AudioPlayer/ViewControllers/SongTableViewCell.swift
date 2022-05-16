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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        songPhotoImageView.layer.cornerRadius = 32
        songPhotoImageView.layer.borderColor = UIColor.cyan.cgColor
        songPhotoImageView.layer.borderWidth = 1
    }
    
    func setCell(name: String) {
        nameSongLabel.text = name
        songPhotoImageView.image = UIImage(named: name)
    }
    
}
