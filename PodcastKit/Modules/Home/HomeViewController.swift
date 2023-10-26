//
//  HomeViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 29/12/22.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newPodcast : [Podcast] = []
    var recentPodcast : [Podcast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadData()
        loadRecentPodcast()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func handleResponse (_ response: [Podcast]) {
        self.newPodcast = response
        self.tableView.reloadData()
    }
    
    func loadData() {
        APIService.shared.getNewPodcast(completion: handleResponse)
    }
    
    func loadRecentPodcast () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        recentPodcast = DPodcast.fetch(context: context)
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return 1
        case 1 :
            return recentPodcast.count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "new_cell_id", for: indexPath) as! HomeNewPodacstTableViewCell
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.reloadData()
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "recent_cell_id", for: indexPath) as! HomeRecentViewCell
            
            let podcast = recentPodcast[indexPath.row]
            cell.numberLabel.text = String(format: "%02d", indexPath.row + 1)
            cell.thumbImageView.kf.setImage(with: URL(string: podcast.artworkUrl))
            cell.titleLabel.text = podcast.trackName
            cell.subtitleLable.text = podcast.artistName
            cell.delegate = self
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0 :
            return "New Podcast"
        default:
            return "Recent Episodes"
        }
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = self.recentPodcast[indexPath.row]
        let alert = UIAlertController(title: "Row Selected", message: " \(podcast.trackName) is selected", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (alertAction) in
            print(" \(podcast.trackName) is selected")
            tableView.deselectRow(at: indexPath, animated: true)
        }))
        present(alert, animated: true)
    }
}

extension HomeViewController: HomeRecentViewDelegate {
    func homeCellEllipsisButtonTapped(cell: HomeRecentViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            let actionSheet = UIAlertController(title: "More \(indexPath.row + 1)", message: "Select Action", preferredStyle: UIAlertController.Style.actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                print("OK Action Tapped at \(indexPath.row + 1)")
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
            present(actionSheet, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPodcast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcast_cell_id", for: indexPath) as! HomePodcastViewCell
        
        let podcast = newPodcast[indexPath.item]
        cell.imageView.kf.setImage(with: URL(string: podcast.artworkUrl))

        cell.titleLabel.text = podcast.trackName
        cell.subTitleLabel.text = podcast.artistName
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let podcast = newPodcast[indexPath.item]
        showEpisodesViewController(podcast: podcast)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
