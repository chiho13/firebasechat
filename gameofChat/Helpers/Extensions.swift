//
//  Extensions.swift
//  gameofChat
//
//  Created by Anthony Ho on 30/10/2018.
//  Copyright © 2018 Anthony Ho. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        //check cache for image first
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: ({ (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            guard let imageData = UIImage(data: data!) else { return }
            DispatchQueue.main.async {
                imageCache.setObject(imageData, forKey: urlString as AnyObject)
                self.image = imageData
            }
        })).resume()
    }
}
