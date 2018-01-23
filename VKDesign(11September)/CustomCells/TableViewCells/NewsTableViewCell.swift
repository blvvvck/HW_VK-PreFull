//
//  NewsTableViewCell.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 02/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import UIKit

protocol NewsTableDelegate {
    func didTapLike(with id: Int)
}

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var userSurnameLabel: UILabel!
    @IBOutlet weak var newImage: UIImageView!
    var newsId: Int = 0
    
    @IBOutlet weak var avatarToNoteConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarToImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteToImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var noteToLikeConstraint: NSLayoutConstraint!
    let likeIcon = UIImage(named: "like2")
    let unlikeIcon = UIImage(named: "like1")
    
    var delegate: NewsTableDelegate?
    
     let radiusRoundCorner: CGFloat = 50
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        delegate?.didTapLike(with: newsId)
        
            RequestManager.instance.isLiked(with: self.newsId) { (result) in
                if result == 0 {
                    DispatchQueue.main.async {
                        self.likeButton.setImage(self.likeIcon, for: .normal)
                        self.likesLabel.text = String(Int(self.likesLabel.text!)! + 1)
                    }
                    
                }
                if result == 1 {
                    DispatchQueue.main.async {
                        self.likeButton.setImage(self.unlikeIcon, for: .normal)
                        self.likesLabel.text = String(Int(self.likesLabel.text!)! - 1)
                    }
                    
                }
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newImage?.image = nil
    }
    
    func prepare(with newsModel: News) {
        
        if let id = Int(newsModel.id) {
            newsId = id
        }
        
        if let link = newsModel.image {
            newImage.downloadedFrom(link: link)
        }
        
        let textIsEmpty = newsModel.text == nil
        
        if textIsEmpty, newsModel.image != nil {
            noteLabel.isHidden = true
            avatarToNoteConstraint.priority = .defaultLow
            avatarToImageConstraint.priority = .defaultHigh
        }
        
        if !textIsEmpty, newsModel.image != nil {
            noteLabel.isHidden = false
            avatarToImageConstraint.priority = .defaultLow
            avatarToNoteConstraint.priority = .defaultHigh
        }
        
        if !textIsEmpty, newsModel.image == nil {
            imageView?.isHidden = true
            noteToImageConstraint.priority = .defaultLow
            noteToLikeConstraint.priority = .defaultHigh
        }
        
        if !textIsEmpty, newsModel.image != nil {
            imageView?.isHidden = false
            noteToLikeConstraint.priority = .defaultLow
            noteToImageConstraint.priority = .defaultHigh
        }
        
        noteLabel.text = newsModel.text
        likesLabel.text = newsModel.likesCount
        commentsLabel.text = newsModel.commentsCount
        repostsLabel.text = newsModel.repostsCount
      
        
        userNameLabel.text = newsModel.name
        userSurnameLabel.text = newsModel.surname
        dateLabel.text = newsModel.date
        userAvatarImage.roundCorners([.bottomLeft, .bottomRight, .topLeft, .topRight], radius: radiusRoundCorner)
    }
}
