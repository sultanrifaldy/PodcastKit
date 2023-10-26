//
//  HomeRecentViewCell.swift
//  PodcastKit
//
//  Created by Sultan Rifaldy on 30/12/22.
//

import UIKit

class HomeRecentViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLable: UILabel!
    
    @IBOutlet weak var ellipsisButton: UIButton!
    
    weak var delegate: HomeRecentViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setUp () {
        thumbImageView.layer.cornerRadius = 3
        thumbImageView.layer.masksToBounds = true
    }
    
    @IBAction func ellipsisButtonTapped(_ sender: UIButton) {
        delegate?.homeCellEllipsisButtonTapped(cell: self)
    }
}

protocol HomeRecentViewDelegate: NSObjectProtocol {
    func homeCellEllipsisButtonTapped (cell: HomeRecentViewCell)
}
