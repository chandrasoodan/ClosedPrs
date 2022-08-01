//
//  Extensions.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation
import UIKit
extension UIView{
    func pinAllEdges(viewToPin: UIView , insets:[CGFloat]){
        //insets:- [top,bottom,left,right]
        viewToPin.translatesAutoresizingMaskIntoConstraints = false
        viewToPin.topAnchor.constraint(equalTo: self.topAnchor, constant: insets[0]).isActive = true
        viewToPin.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets[1]).isActive = true
        viewToPin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets[2]).isActive = true
        viewToPin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets[3]).isActive = true
    }
    
    func setCardView(){
        
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:2, height: 2)
        layer.masksToBounds = false
        
      
    }
    
    func loadCardViewStyleForView() {
        let shadowSize : CGFloat = 2.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 1
        self.layer.cornerRadius = 5.0
        self.layer.shadowPath = shadowPath.cgPath
        

    }
    
}
let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: UIImageView {

    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()

    func loadImageWithUrl(_ url: URL) {

        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    if self.imageURL == url {
                        self.image = imageToCache
                    }

                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
