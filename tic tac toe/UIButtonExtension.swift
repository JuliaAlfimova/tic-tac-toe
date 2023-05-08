//
//  UIButtonExtension.swift
//  tic tac toe
//
//  Created by juliemoorled on 06.05.2023.
//

import UIKit

extension UIButton {

    func animateButton() {
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseInOut,
                       animations: { self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) },
                       completion: { _ in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.6,
                           options: .curveEaseInOut,
                           animations: { self.transform = CGAffineTransform.identity },
                           completion: nil)
        })
    }

}
