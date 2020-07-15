//
//  UserDetailViewController.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit
import QuartzCore

class UserDetailViewController: UIViewController {
    
    @IBOutlet private var avatar: LazyImageView! {
        didSet {
            avatar.layer.cornerRadius = avatar.bounds.size.width/2
            avatar.clipsToBounds = true
            avatar.layer.borderColor = UIColor.gray.cgColor
            avatar.layer.borderWidth = 1
        }
    }
    @IBOutlet private var name: UILabel!
    @IBOutlet private var designation: UILabel!
    @IBOutlet private var city: UILabel!
    @IBOutlet private var about: UILabel!
    
    var viewModel: UserDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        self.title = "User Profile"
        self.avatar.imageURL = self.viewModel?.avatar
        self.name.text = self.viewModel?.name
        self.designation.text = self.viewModel?.designation
        self.city.text = self.viewModel?.city
        self.about.text = self.viewModel?.about
    }
}
