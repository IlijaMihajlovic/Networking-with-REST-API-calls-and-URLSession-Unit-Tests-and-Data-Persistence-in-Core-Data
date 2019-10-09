//
//  ImageService.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url: URL, compeltion: @escaping (_ image: UIImage?) -> ()) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var downloadedImage: UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                compeltion(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withURL url: URL, compeltion: @escaping (_ image: UIImage?) -> ()) {
    
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            compeltion(image)
        } else {
            downloadImage(withURL: url, compeltion: compeltion)
        }
    
    }
}
