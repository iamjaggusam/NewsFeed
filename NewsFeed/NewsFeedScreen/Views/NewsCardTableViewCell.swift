//
//  NewsCardTableViewCell.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import UIKit

class NewsCardTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var urlLinkButton: UIButton!
    @IBOutlet weak var newsImage: UIImageView!
    var buttonTapped : ((NewsCardTableViewCell) -> Void)?
    
    let dummyImage = "https://picsum.photos/seed/picsum/200/300"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        buttonTapped?(self)
    }
    
    func configureCell(usingViewModel viewModel: NewsFeedViewModel) -> Void {
        self.authorLabel.text = viewModel.author
        self.sourceLabel.text = viewModel.name
        self.titleLabel.text = viewModel.title
        self.descriptionTextView.text = viewModel.description
        self.urlLinkButton.setTitle(viewModel.url, for: .normal)
        self.newsImage.load(url: viewModel.image.isEmpty ? dummyImage : viewModel.image)
    }
}
