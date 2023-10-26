//
//  MainViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 16/12/22.
//

import UIKit
import FeedKit

class MainViewController: UITabBarController{
    weak var playerView: PlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderStateDidChange(_:)),
            name: .PlayerProviderStateDidChange,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.playerProviderNowPlayingInfoDidChange(_:)),
            name: .PlayerProviderStateDidChange,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self.playerProviderNowPlayingInfoDidChange(_:),
            name: .PlayerProviderNowPlayingInfoDidChange,
            object: nil)
        NotificationCenter.default.removeObserver(
            self.playerProviderStateDidChange(_:),
            name: .PlayerProviderStateDidChange,
            object: nil)
    }
    
    func setUp () {
        let playerView = PlayerView(frame: .zero)
        view.addSubview(playerView)
        self.playerView = playerView
        playerView.isHidden = true
        playerView.delegate = self
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
        view.bringSubviewToFront(playerView)
    }
    
    @objc func playerProviderStateDidChange(_ sender: Any) {
        playerProviderNowPlayingInfoDidChange(sender)
        playerView.isHidden = false
    }
    
    @objc func playerProviderNowPlayingInfoDidChange(_ sender: Any) {
        let playerProvider = PlayerProvider.shared
        let episode = playerProvider.currentEpisode
        
        playerView.titleLabel.text = episode?.epTitle
        playerView.imageView.kf.setImage(with: URL(string: episode?.imageUrl ?? ""))
        let imageName = playerProvider.isPodcastPlaying() ? "pause.fill" : "play.fill"
        playerView.playButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

}

//PlayerViewDelegate
extension MainViewController: PlayerViewDelegate {
    func playerViewPlayButtonTapeed(_ view: PlayerView) {
        PlayerProvider.shared.podcastPlay()
    }
    
    func playerViewForwardButtonTapeed(_ view: PlayerView) {
        PlayerProvider.shared.podcastForward()
    }
    
    func playerViewRewindButtonTapeed(_ view: PlayerView) {
        PlayerProvider.shared.podcastRewind()
    }
    
    func playerViewViewTapeed(_ view: PlayerView) {
        if let episode = PlayerProvider.shared.currentEpisode {
            presentPlayerViewController(episode: episode)
        }
    }
}
