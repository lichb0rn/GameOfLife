//
//  UImage+Extension.swift
//  GameOfLife
//
//  Created by Miroslav Taleiko on 06.03.2022.
//

import UIKit

extension UIImage {
    func resize(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
