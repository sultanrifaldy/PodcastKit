//
//  SearchResponse.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 04/01/23.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
