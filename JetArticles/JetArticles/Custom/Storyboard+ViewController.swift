//
//  Storyboard+ViewController.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/15/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func viewController(with identier: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: identier)
    }
}
