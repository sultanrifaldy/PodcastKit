//
//  FavoritesViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 30/01/23.
//

import UIKit

class FavoritesViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var favorites: [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
        loadFavorites()
    }
    
    func setUp () {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func loadFavorites() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        self.favorites = DPodcast.fetch(context: context)
    }

}

//MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorite_cell_id", for: indexPath) as! FavoriteViewCell
        let podcast = favorites[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: podcast.artworkUrl))
        cell.titleLabel.text = podcast.trackName
        cell.subtitleLabel.text = podcast.artistName
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension FavoriteViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let width = floor((screenWidth - 60) / 2)
        let height = width + 8 + 85
        return CGSize(width: width, height: height)
    }
}

//MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = favorites[indexPath.item]
        showEpisodesViewController(podcast: podcast)
    }
}
