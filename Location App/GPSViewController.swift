//
//  GPSViewController.swift
//  Location App
//
//  Created by d.boone on 4/16/23.
//

import UIKit
import CoreLocation
class GPSViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet var distanceLabel: UILabel!
    
    
    let locMan: CLLocationManager = CLLocationManager()
    var startLocation:  CLLocation!
    
    let floLongitude: CLLocationDegrees = -81.760254
    let flolatitude: CLLocationDegrees = 27.994402
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let newLocation: CLLocation=locations[0]
        NSLog("Something is happening")
        
        if newLocation.horizontalAccuracy>=0 {
            let flo:CLLocation = CLLocation(latitude: flolatitude, longitude: floLongitude)
            let delta:CLLocationDistance = flo.distance(from: newLocation)
            let miles: Double = (delta * 0.000621371) + 0.5
            if miles < 3 {
                locMan.stopUpdatingLocation()
                distanceLabel.text = " Enjoy\nFlorida!"
                
            }else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                distanceLabel.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to Florida"
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locMan.delegate = self
        locMan.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locMan.distanceFilter = 1609;
        locMan.requestWhenInUseAuthorization()
        locMan.startUpdatingLocation()
        startLocation = nil
        
        
        
        
        
        
        
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
