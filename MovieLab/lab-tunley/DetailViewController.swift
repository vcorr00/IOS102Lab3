//
//  DetailViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/5/22.
//

import UIKit
import Nuke


class DetailViewController: UIViewController {

    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!

    // TODO: Pt 1 - Add a track property

    var track: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: Pt 1 - Configure the UI elements with the passed in track
        
        // Load the image located at the `artworkUrl100` URL and set it on the image view.
        Nuke.loadImage(with: track.artworkUrl100 as ImageRequestConvertible, into: trackImageView)

            // Set labels with the associated track values.
            trackNameLabel.text = track.movieName
            artistLabel.text = track.descriptionText
            albumLabel.text = String(track.ratingNumber)
            genreLabel.text = String(track.voteTotals)

            // Create a date formatter to style our date and convert it to a string
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            releaseDateLabel.text = dateFormatter.string(from: track.releaseDate)

            // Use helper method to convert milliseconds into `mm:ss` string format


    }



}
