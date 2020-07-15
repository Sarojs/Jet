//
//  UserTableViewCell.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit
import QuartzCore

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private var avatar: LazyImageView! {
        didSet {
            avatar.layer.cornerRadius = avatar.bounds.size.width/2
            avatar.clipsToBounds = true
            avatar.layer.borderColor = UIColor.gray.cgColor
            avatar.layer.borderWidth = 1
        }
    }
    @IBOutlet private var username: UILabel!
    @IBOutlet private var designation: UILabel!
    @IBOutlet private var city: UILabel!
    
    private var viewModel: UserCellViewModel?
    
    func configure(with viewModel: UserCellViewModel) {
        
        self.viewModel = viewModel
        
        self.username.text = viewModel.username
        self.designation.text = viewModel.designation
        self.city.text = viewModel.city
        self.avatar.imageURL = viewModel.avatar
    }
}
