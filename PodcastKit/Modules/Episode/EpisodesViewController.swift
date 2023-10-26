//
//  EpisodesViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 11/01/23.
//

import UIKit
import FeedKit
import Kingfisher

class EpisodesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var podcast: Podcast!
    var episodes: [RSSFeedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        loadEpisodes()
    }
    func setUp () {
        title = podcast.trackName
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    func loadEpisodes () {
        APIService.shared.loadEpisode(url: podcast.feedUrl) { episodes in
            self.episodes = episodes
            self.tableView.reloadData()
        }
    }
}

extension EpisodesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode_cell_id", for: indexPath) as! EpisodeViewCell
        let episode = episodes[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: episode.iTunes?.iTunesImage?.attributes?.href ?? ""))
        cell.dateLabel.text = episode.pubDate?.description
        cell.titleLabel.text = episode.title
        cell.descLabel.text = episode.iTunes?.iTunesSubtitle ?? episode.description
        return cell
    }
}

extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        presentPlayerViewController(episode: episode)
    }
}


extension UIViewController {
    func showEpisodesViewController (podcast: Podcast) {
        let storyboard = UIStoryboard(name: "Episode", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "episodes") as! EpisodesViewController
        viewController.podcast = podcast
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
