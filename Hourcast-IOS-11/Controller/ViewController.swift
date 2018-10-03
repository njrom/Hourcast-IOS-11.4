//
//  ViewController.swift
//  Hourcast-IOS-11
//
//  Created by Nicholas Romano on 10/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    // IBOutlets for Selected Hours Weather 
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedWeatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // IBOutlets for Hourly Stack
    @IBOutlet var hourImageViews : [UIImageView]!
    @IBOutlet var hourLabels : [UILabel]!
    @IBOutlet var hourStacks : [UIStackView]!
    

    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/forecast"
    let APP_ID = "a87ba5e03928db05eebc6909808825ff"
    
    
    let locationManager = CLLocationManager()
    
    let weatherFetcher = WeatherDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        if let stacks = hourStacks {
           for stack in stacks { // Adding Tapping abilities to each of the hour stacks
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hourTapped(tapGestureRecognizer:)))
                stack.isUserInteractionEnabled = true
                stack.addGestureRecognizer(tapGestureRecognizer)
            
            }
        } else {
            print("Error Hour Stacks were not linked properly")
        }
    }
    
    
    @objc func hourTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedStack = tapGestureRecognizer.view as! UIStackView
        for label in hourLabels {
            label.backgroundColor = UIColor.clear //TODO: Fix this make it better
        }
        if let index = hourStacks?.index(of: tappedStack) {
            print(index)
            selectedWeatherImageView.image = hourImageViews[index].image
            hourLabels[index].backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
            //TODO: implement switcher (current weather switches to weather at index)
        } else {
            print("Error with stack linkage")
        }
        
    }
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // Last value in the CLLocation array is the most precise
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let params : [String : String] = ["lat": String(latitude), "lon": String(longitude),"appid":APP_ID]
            
            weatherFetcher.fetchWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    
    
}

