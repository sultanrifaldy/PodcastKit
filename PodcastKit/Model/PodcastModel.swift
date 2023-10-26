//
//  PodcastModel.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 30/12/22.
//

import Foundation

struct Podcast: Decodable {
    let trackName: String
    let artistName: String
    let artworkUrl: String
    let trackCount: Int
    let genre: [String]
    let feedUrl: String
    let trackId: Int
    let collectionId: Int
    
    
    enum CodingKeys: String, CodingKey{
        case trackName
        case artistName
        case artworkUrl = "artworkUrl600"
        case trackCount
        case genre
        case feedUrl
        case trackId
        case collectionId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.trackName = try container.decodeIfPresent(String.self, forKey: .trackName) ?? ""
        self.artistName = try container.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        self.artworkUrl = try container.decodeIfPresent(String.self, forKey: .artworkUrl) ?? ""
        self.trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount) ?? 0
        self.genre = try container.decodeIfPresent([String].self, forKey: .genre) ?? []
        self.feedUrl = try container.decodeIfPresent(String.self, forKey: .feedUrl) ?? ""
        self.trackId = try container.decodeIfPresent(Int.self, forKey: .trackId) ?? 0
        self.collectionId = try container.decodeIfPresent(Int.self, forKey: .collectionId) ?? 0
    }
    
    init(data: DPodcast) {
        trackId = Int(data.trackId)
        trackName = data.trackName ?? ""
        artistName = data.artistName ?? ""
        artworkUrl = data.artworkUrl ?? ""
        trackCount = Int(data.trackCount)
        genre = []
        feedUrl = data.feedUrl ?? ""
        collectionId = 0
    }
}

