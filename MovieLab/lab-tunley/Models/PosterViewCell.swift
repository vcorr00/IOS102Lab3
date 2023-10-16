//
//  PosterViewCell.swift
//  lab-tunley
//
//  Created by Vladimir Corrales on 10/16/23.
//

import UIKit
import Nuke

class PosterViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("Cell initialized")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Cell initialized via coder")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib called")
    }
    
    func configure(with track: Movie) {
            Nuke.loadImage(with: track.artworkUrl100 as ImageRequestConvertible, into: albumImageView)
    }
}
