//
//  Poster.swift
//  lab-tunley
//
//  Created by Vladimir Corrales on 10/16/23.
//

import Foundation
struct AlbumSearchResponse: Decodable {
    let results: [Album]
}

struct Album: Decodable {
    let artworkUrl100: URL
}
