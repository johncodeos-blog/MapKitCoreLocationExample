//
//  DirectionsViewController.swift
//  MapKitCoreLocationExample
//
//  Created by John Codeos on 2/3/21.
//

import MapKit
import UIKit

class DirectionsViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!

    @IBOutlet var instructionsLabel: UILabel!
    @IBOutlet var noticeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var previousStepBtn: UIButton!
    @IBOutlet var nextStepBtn: UIButton!

    var currentRoute: MKRoute?

    var currentStepIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        getDirections()

        // Customizing UI
        previousStepBtn.clipsToBounds = true
        previousStepBtn.layer.cornerRadius = 15

        nextStepBtn.clipsToBounds = true
        nextStepBtn.layer.cornerRadius = 15

        distanceLabel.clipsToBounds = true
        distanceLabel.layer.cornerRadius = 25
        distanceLabel.layer.borderWidth = 2
        distanceLabel.layer.borderColor = UIColor.black.cgColor
    }

    func getDirections() {
        let request = MKDirections.Request()
        // Source
        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 39.058, longitude: -100.21))
        request.source = MKMapItem(placemark: sourcePlaceMark)
        // Destination
        let destPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 36.79, longitude: -98.64))
        request.destination = MKMapItem(placemark: destPlaceMark)
        // Transport Types
        request.transportType = [.automobile, .walking]

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "No error specified").")
                return
            }

            let route = response.routes[0]
            self.currentRoute = route
            self.displayCurrentStep()
            self.mapView.addOverlay(route.polyline)
        }
    }

    func displayCurrentStep() {
        guard let currentRoute = currentRoute else { return }
        if currentStepIndex >= currentRoute.steps.count { return }
        let step = currentRoute.steps[currentStepIndex]

        instructionsLabel.text = step.instructions
        distanceLabel.text = "\(distanceConverter(distance: step.distance))"

        // Hide the noticeLabel if notice doesn't exist
        if step.notice != nil {
            noticeLabel.isHidden = false
            noticeLabel.text = step.notice
        } else {
            noticeLabel.isHidden = true
        }

        // Enable/Disable buttons according to the step they are
        previousStepBtn.isEnabled = currentStepIndex > 0
        nextStepBtn.isEnabled = currentStepIndex < (currentRoute.steps.count - 1)

        // Add padding around the route
        let padding = UIEdgeInsets(top: 40, left: 40, bottom: 100, right: 40)
        mapView.setVisibleMapRect(step.polyline.boundingMapRect, edgePadding: padding, animated: true)
    }

    func distanceConverter(distance: CLLocationDistance) -> String {
        let lengthFormatter = LengthFormatter()
        lengthFormatter.numberFormatter.maximumFractionDigits = 2
        if NSLocale.current.usesMetricSystem {
            return lengthFormatter.string(fromValue: distance / 1000, unit: .kilometer)
        } else {
            return lengthFormatter.string(fromValue: distance / 1609.34, unit: .mile)
        }
    }

    @IBAction func previousStepBtnAction(_ sender: UIButton) {
        if currentRoute == nil { return }
        if currentStepIndex <= 0 { return }
        currentStepIndex -= 1
        displayCurrentStep()
    }

    @IBAction func nextStepBtnAction(_ sender: UIButton) {
        guard let currentRoute = currentRoute else { return }
        if currentStepIndex >= (currentRoute.steps.count - 1) { return }
        currentStepIndex += 1
        displayCurrentStep()
    }
}

extension DirectionsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        // Set the color for the line
        renderer.strokeColor = .red
        return renderer
    }
}
