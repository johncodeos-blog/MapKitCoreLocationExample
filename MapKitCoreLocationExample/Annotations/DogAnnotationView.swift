//
//  DogAnnotationView.swift
//  MapKitCoreLocationExample
//
//  Created by John Codeos on 1/30/21.
//

import Foundation
import MapKit
import UIKit

class DogAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // Resize image
            let pinImage = UIImage(named: "dog")
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

            // Add Image
            self.image = resizedImage
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // Enable callout
        self.canShowCallout = true

        // Move the image a little bit above the point.
        self.centerOffset = CGPoint(x: 0, y: -20)
    }
}
