//
//  ArticleCellView.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit
import QuartzCore

class ArticleCellView: UITableViewCell {
    
    @IBOutlet private var iconView: LazyImageView! {
        didSet {
            iconView.layer.cornerRadius = iconView.bounds.size.width/2
            iconView.clipsToBounds = true
            iconView.layer.borderColor = UIColor.gray.cgColor
            iconView.layer.borderWidth = 1
        }
    }
    @IBOutlet private var username: UILabel!
    @IBOutlet private var designation: UILabel!
    @IBOutlet private var time: UILabel!
    
    @IBOutlet private var thumbnailImageView: LazyImageView!
    
    @IBOutlet private var content: UILabel!
    
    @IBOutlet private var likes: UILabel!
    @IBOutlet private var comments: UILabel!
    
    var viewModel: ArticleCellViewModel?
    
    func configure(with viewModel: ArticleCellViewModel) {
        
        self.viewModel = viewModel
        
        self.username.text = viewModel.username
        self.designation.text = viewModel.designation
        self.time.text = viewModel.time
        self.content.text = viewModel.content
        self.likes.text = viewModel.like
        self.comments.text = viewModel.comment
        
        self.iconView.imageURL = viewModel.avatar
        self.thumbnailImageView.imageURL = viewModel.mediaImage
    }
}
