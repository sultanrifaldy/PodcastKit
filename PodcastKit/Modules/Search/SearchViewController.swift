//
//  SearchViewController.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 07/01/23.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var searchTextField: UITextField!
    
    let searchController = UISearchController(searchResultsController: nil)

    
    var podcasts: [Podcast] = []
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     // Do any additional setup after loading the view.
        setUp()
        getCoreDataDBPath()
    }
    func getCoreDataDBPath() {
        let path = FileManager
            .default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .last?
            .absoluteString
            .replacingOccurrences(of: "file://", with: "")
            .removingPercentEncoding

         print("Core Data DB Path :: \(path ?? "Not found")")
    }
    
    func setUp () {
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchBar.delegate = self
//        searchTextField.delegate = self
    }
    
    func searchPodcasts (term: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            APIService.shared.searchPodcasts(term: term) { podcast in
                self.podcasts = podcast
                self.tableView.reloadData()
            }
        })
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcast_cell_id", for: indexPath) as! SearchPodcastViewCell
        
        let podcast = podcasts[indexPath.row]
        cell.thumbImageView.kf.setImage(with: URL(string: podcast.artworkUrl))
        cell.nameLabel.text = podcast.trackName
        cell.artistLabel.text = podcast.artistName
        cell.episodeLabel.text = "\(podcast.trackName) episode(s)"
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let podcast = podcasts[indexPath.row]
        showEpisodesViewController(podcast: podcast)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let podcast = podcasts[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Favorite", handler: { (_, _, completion) in
            
            DPodcast.save(podcast, context: context)
            completion(true)
        })
        
        favoriteAction.backgroundColor = UIColor.systemYellow
        favoriteAction.image = UIImage(systemName: "star.fill")
        
        let config = UISwipeActionsConfiguration(actions: [
            favoriteAction
        ])
        
        return config
    }
    
}


//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            searchPodcasts(term: searchText)
        }
    }
}

//MARK: - UITextFieldDelegate
//extension SearchViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
//        if newString.count >= 3 {
//            searchPodcasts(term: newString)
//        }
//
//        return true
//    }
//}
