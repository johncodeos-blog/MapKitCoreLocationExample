//
//  AnnotationsViewController.swift
//  MapKitCoreLocationExample
//
//  Created by John Codeos on 1/20/21.
//

import CoreLocation
import MapKit
import UIKit

class AnnotationsViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Simple Annotations
        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = CLLocationCoordinate2D(latitude: 33.95, longitude: -117.34)
        annotation1.title = "Example 0" // Optional
        annotation1.subtitle = "Example 0 subtitle" // Optional
        mapView.addAnnotation(annotation1)

        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = CLLocationCoordinate2D(latitude: 32.78, longitude: -112.43)
        annotation2.title = "Example 1" // Optional
        annotation2.subtitle = "Example 1 subtitle" // Optional
        mapView.addAnnotation(annotation2)

        let annotation3 = MKPointAnnotation()
        annotation3.coordinate = CLLocationCoordinate2D(latitude: 35.58, longitude: -107.00)
        annotation3.title = "Example 2" // Optional
        annotation3.subtitle = "Example 2 subtitle" // Optional
        mapView.addAnnotation(annotation3)

        mapView.delegate = self

        // Using Classic Old Pin as a Annotation View
        // self.mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)

        // Using custom image(dog) as a Annotation View
        mapView.register(DogAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}

extension AnnotationsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // If you're showing the user's location on the map, don't set any view
        if annotation is MKUserLocation { return nil }

        let id = MKMapViewDefaultAnnotationViewReuseIdentifier

        // Balloon Shape Pin (iOS 11 and above)
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKMarkerAnnotationView {
            // Customize only the 'Example 0' Pin
            if annotation.title == "Example 0" {
                view.titleVisibility = .visible // Set Title to be always visible
                view.subtitleVisibility = .visible // Set Subtitle to be always visible
                view.markerTintColor = .yellow // Background color of the balloon shape pin
                view.glyphImage = UIImage(systemName: "plus.viewfinder") // Change the image displayed on the pin (40x40 that will be sized down to 20x20 when is not tapped)
                // view.glyphText = "!" // Text instead of image
                view.glyphTintColor = .black // The color of the image if this is a icon
                return view
            }
        }

        // Classic old Pin (iOS 10 and below)
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
            // Customize only the 'Example 0' Pin
            if annotation.title == "Example 0" {
                view.animatesDrop = true // Animates the pin when shows up
                view.pinTintColor = .yellow // The color of the head of the pin
                view.canShowCallout = true // When you tap, it shows a bubble with the title and the subtitle
                return view
            }
        }
        return nil
    }
}
