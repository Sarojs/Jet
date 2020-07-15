//
//  LazyImageView.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import UIKit

class LazyImageView: UIImageView {
    
    var imageURL: String? = nil {
        didSet {
            guard let string = imageURL, let url = URL(string: string) else {
                self.image = nil
                return
            }
            
            guard let image = ImageCache().imageData(for: string) else {
                self.image = nil
                self.download(url: url)
                return
            }
            self.image = image
        }
    }
}

// MARK: Download image

extension LazyImageView {
    
    func download(url: URL) {
        
        DispatchQueue.global().async {
            
            let request = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                guard error == nil, let imageData = data, let image = UIImage(data: imageData) else { return }
                
                if let key = self.imageURL {
                    ImageCache().store(imageData: image, for: key)
                }
                
                DispatchQueue.main.async {
                    self.image = image
                }
            }).resume()
        }
    }
}
