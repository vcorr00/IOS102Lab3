//
//  Track.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/2/22.
//
import Nuke
import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let movieName: String
    let descriptionText: String
    let artworkUrl100: URL
    let ratingNumber: Double
    let voteTotals: Int
    let releaseDate: Date
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private enum CodingKeys: String, CodingKey {
        case title
        case overview
        case poster_path
        case vote_average
        case vote_count
        case release_date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        movieName = try container.decode(String.self, forKey: .title)
        descriptionText = try container.decode(String.self, forKey: .overview)
        
        let backdropPath = try container.decode(String.self, forKey: .poster_path)
        let baseURLString = "https://image.tmdb.org/t/p/"
        let imageSize = "w500"
        
        // Construct the complete imageURLString by appending the backdropPath
        let imageURLString = baseURLString + imageSize + backdropPath
        
        // Convert the imageURLString to a URL
        if let imageURL = URL(string: imageURLString) {
            artworkUrl100 = imageURL
        } else {
            throw DecodingError.dataCorruptedError(forKey: .poster_path, in: container, debugDescription: "Invalid URL format for poster_path.")
        }
        
        ratingNumber = try container.decode(Double.self, forKey: .vote_average)
        voteTotals = try container.decode(Int.self, forKey: .vote_count)
        
        let releaseDateString = try container.decode(String.self, forKey: .release_date)
        if let releaseDate = Movie.dateFormatter.date(from: releaseDateString) {
            self.releaseDate = releaseDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .release_date, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}
