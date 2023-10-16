//
//  TrackCell.swift
//  lab-tunley
//
//  Created by Vladimir Corrales on 9/26/23.
//
import Nuke
import UIKit

class TrackCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var trackImageView: UIImageView!
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    @IBOutlet weak var artistNameLabel: UILabel!
    
    func configure(with track: Movie) {
        trackNameLabel.text = track.movieName
        artistNameLabel.text = track.descriptionText

        // Load image async via Nuke library image loading helper method
        Nuke.loadImage(with: track.artworkUrl100 as ImageRequestConvertible, into: trackImageView)
    }
}
