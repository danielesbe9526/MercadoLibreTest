//
//  UIImageView+extension.swift
//  MercadoLibreApp
//
//  Created by Daniel Beltran😎 on 31/10/20.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImagesFrom(_ urlString: String) {
        image = nil
        
        let url =  URL(string: urlString)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.image = imageToCache
                }
            }
        })
        task.resume()
    }
}
