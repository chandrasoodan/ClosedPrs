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
}
