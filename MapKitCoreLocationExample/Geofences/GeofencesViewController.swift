//
//  GeofencesViewController.swift
//  MapKitCoreLocationExample
//
//  Created by John Codeos on 1/26/21.
//

import CoreLocation
import UIKit

class GeofencesViewController: UIViewController {
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        monitorGeofences()
    }

    func monitorGeofences() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let coord = CLLocationCoordinate2D(latitude: 35.58, longitude: 107.00)
            let region = CLCircularRegion(center: coord, radius: 100, identifier: "Geofence1")
            region.notifyOnEntry = true
            region.notifyOnExit = true

            locationManager.startMonitoring(for: region)
        }
    }
}

extension GeofencesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("User has entered \(region.identifier)")
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("User has exited \(region.identifier)")
    }
}
