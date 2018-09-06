//
//  ViewController.swift
//  NMMoney
//
//  Created by Евгений Махнач on 24.08.2018.
//  Copyright © 2018 Евгений Махнач. All rights reserved.
//

import UIKit
import CoreLocation
class StartVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var bookBtnLeft: UIButton!
    @IBOutlet weak var bookBtnRight: UIButton!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        RealmService.deleteBook()
        RealmService.deleteSlots()
        RealmService.deleteBranchTime()
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        getAddressFromLatLon(pdblLatitude: String(describing: locValue.latitude), withLongitude: String(describing: locValue.longitude))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        bookBtnLeft.roundCorners(.allCorners, radius: 12)
        bookBtnRight.roundCorners(.allCorners, radius: 12)
    }


    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    RealmService.deleteAddresses()
                    let addressInstance = AddressModel()
                    addressInstance.address = addressString
                    addressInstance.lat = pdblLatitude
                    addressInstance.long = pdblLongitude
                    RealmService.writeIntoRealm(object: addressInstance)
                    print(addressString)
                }
        })
        
    }
    
    
    @IBAction func pushVideo(_ sender: UIButton) {
        GetToken.getToken { (completion) in
            if completion {
                GetBranches.getBranches(completion: { (completion) in
                    if completion {
                        self.pushVC(identifier: "kVideoVC")
                    }
                })
            }
        }
    }

    @IBAction func pushPhone(_ sender: UIButton) {
        GetToken.getToken { (completion) in
            if completion {
                GetBranches.getBranches(completion: { (completion) in
                    if completion {
                        self.pushVC(identifier: "kPhoneVC")
                    }
                })
            }
        }
    }
    
    
}

