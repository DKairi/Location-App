//
//  GPSViewController.swift
//  Location App
//
//  Created by d.boone on 4/16/23.
//

import UIKit
import CoreLocation
import WebKit
import MessageUI
class GPSViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
    

    
    @IBOutlet var distanceLabel: UILabel?
    
    
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
                distanceLabel?.text = " Enjoy\nFlorida!"
                
            }else {
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                distanceLabel?.text=commaDelimited.string(from: NSNumber(value: miles))!+" miles to Florida"
            }
            
            
            
        }
        
        
        
        
        
    }
    
   
    @IBOutlet var webView: WKWebView?
    
    @IBAction func openSite(_ sender: Any) {
        if let url = URL(string: "https://www.visitflorida.com"){
                      UIApplication.shared.open(url, options:[:])
                  }
    }
    
    
    
    
    @IBAction func sendMessage(_ sender: Any) {
        let SMS = MFMessageComposeViewController()
                SMS.messageComposeDelegate = self
                
                SMS.recipients = ["2404358990"]
                SMS.body = "Hello message!"
                
                if MFMessageComposeViewController.canSendText() {
                    self.present(SMS, animated:true, completion:nil)
                }else{
                    print("Cant send messages.")
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
        
        //load website
        let myURL = URL(string: "https://www.visitflorida.com")
        let myRequest = URLRequest(url: myURL!)
       webView?.load(myRequest)
        
        
        
        
        
        
        
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







