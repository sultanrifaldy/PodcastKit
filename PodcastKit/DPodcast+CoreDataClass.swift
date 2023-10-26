//
//  DPodcast+CoreDataClass.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 24/01/23.
//
//

import Foundation
import CoreData

@objc(DPodcast)
public class DPodcast: NSManagedObject {

    class func save (_ podcast: Podcast, context: NSManagedObjectContext) {
        let request: NSFetchRequest <DPodcast> = DPodcast.fetchRequest()
        request.predicate = NSPredicate(format: "trackId =\(podcast.trackId)")
        
        let entity: DPodcast
        if let dPodcast = try? context.fetch(request).first {
            entity = dPodcast
        } else {
            let dpodcast = NSEntityDescription.entity(forEntityName: "DPodcast", in: context)!
            entity = NSManagedObject(entity: dpodcast, insertInto: context) as! DPodcast
        }
        entity.trackId = Int64(podcast.trackId)
        entity.trackName = podcast.trackName
        entity.artistName = podcast.artistName
        entity.artworkUrl = podcast.artworkUrl
        entity.trackCount = Int16(podcast.trackCount)
        entity.feedUrl = podcast.feedUrl
        
        try? context.save()
        
    }
    
    class func fetch(context: NSManagedObjectContext) -> [Podcast] {
        let request: NSFetchRequest<DPodcast> = DPodcast.fetchRequest()
        let dPodcast = (try? context.fetch(request)) ?? []
        let podcast = dPodcast.compactMap{Podcast(data: $0)}
        return podcast
    }
}
