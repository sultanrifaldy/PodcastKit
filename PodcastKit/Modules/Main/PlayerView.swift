//
//  PlayerView.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 16/01/23.
//

import UIKit

protocol PlayerViewDelegate: NSObjectProtocol{
    func playerViewPlayButtonTapeed (_ view: PlayerView)
    func playerViewForwardButtonTapeed (_ view: PlayerView)
    func playerViewRewindButtonTapeed (_ view: PlayerView)
    func playerViewViewTapeed (_ view: PlayerView)
}


class PlayerView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: PlayerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp () {
        Bundle.main.loadNibNamed("PlayerView", owner: self)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    

    @IBAction func playButtonTapped(_ sender: Any) {
        delegate?.playerViewPlayButtonTapeed(self)
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        delegate?.playerViewViewTapeed(self)
    }
}
