//
//  APIService.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 04/01/23.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    static let shared: APIService = APIService()
    private init () {}
    
    let SEARCH_URL: String = "https://itunes.apple.com/search"
    
    func loadEpisode(url: String, completion: @escaping(_ episodes:[RSSFeedItem]) -> Void) {
        if let feedUrl = URL(string: url) {
            let parser = FeedParser(URL: feedUrl)
            parser.parseAsync { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case.success(let feed):
                        completion(feed.rssFeed?.items ?? [])
                        
                    case.failure(let error):
                        print(error.localizedDescription)
                        completion([])
                    }
                }
            }
        }
        else {
            completion([])
        }
    }
    
    func searchPodcasts(term: String,completion: @escaping (_ podcast: [Podcast]) -> Void) {
        let parameters: [String: Any] = [
            "term": term,
            "limit": 20,
            "media": "podcast"
        ]
        
        AF.request(SEARCH_URL,method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result{
                case .success(let searchResponse):
                    completion(searchResponse.results)
                case .failure(let error):
                    print(error.errorDescription)
                    completion([])
                }
            }
    }
    
    
    func getNewPodcast (completion: @escaping (_ podcast: [Podcast]) -> Void) {
        
        let parameters: [String: Any] = [
            "term": "swift",
            "limit": 7,
            "media": "podcast"
        ]
        
        AF.request(SEARCH_URL,method: .get, parameters: parameters, encoding: URLEncoding.default)
            .responseDecodable(of: SearchResponse.self) { response in
                switch response.result{
                case .success(let searchResponse):
                    completion(searchResponse.results)
                case .failure(let error):
                    print(error.errorDescription)
                    completion([])
                }
            }
    }
}
