//
//  ViewController.swift
//  Hourcast-IOS-11
//
//  Created by Nicholas Romano on 10/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {

    // IBOutlets for Selected Hours Weather
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedWeatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    // IBOutlets for Hourly Stack
    @IBOutlet var hourImageViews : [UIImageView]!
    @IBOutlet var hourLabels : [UILabel]!
    @IBOutlet var hourStacks : [UIStackView]!
    
    var tappedLabel : UILabel? // To manage highlighting of current label

    let WEATHER_URL = "https://api.darksky.net/forecast/"
    let APP_ID = "8cf720cd198a09ad0ad9779de720ae77"
    
    
    let locationManager = CLLocationManager()
    let weatherFetcher = WeatherDataFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Colors
        view.backgroundColor = UIColor(red:0.48, green:0.65, blue:0.82, alpha:1.0)
        
        tappedLabel = hourLabels[0]
        tappedLabel!.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        titleLabel.text = NSLocalizedString("str_titleLabel", comment: "")
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
        tappedLabel!.backgroundColor = UIColor.clear //TODO: Fix this make it better
        if let index = hourStacks?.index(of: tappedStack) {
            print(index)
            selectedWeatherImageView.image = hourImageViews[index].image
            tappedLabel = hourLabels[index]
            tappedLabel!.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
            //TODO: implement switcher (current weather switches to weather at index)
            if weatherFetcher.hourlyWeather.indices.contains(index){
                updateSelectedData(hour: weatherFetcher.hourlyWeather[index])
            }
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
            fetchWeatherData(url: WEATHER_URL, parameters: params)
            
            
        }
    }
    
    var hourlyWeather = [HourWeather]()
    func fetchWeatherData(url: String, parameters: [String : String]) {
        
        Alamofire.request(url+parameters["appid"]!+"/\(parameters["lat"]!),\(parameters["lon"]!)").responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(response.result.error!)")
            }
        }
    }
    // Parses the weather data and returns required HourWeather Array
    func updateWeatherData(json : JSON) {
        var date : String
        var time : String
        for i in 0..<4 {
            let hourJSON = json["hourly"]["data"][i]
            (date, time) = parseDate(jsonDate: hourJSON["time"].intValue)
            weatherFetcher.hourlyWeather.append(HourWeather(date: date, eventTime: time , temp: hourJSON["temperature"].stringValue, condition: hourJSON["icon"].stringValue, desc: hourJSON["summary"].stringValue))
        }
        updateDataOnScreen(hourlyData: weatherFetcher.hourlyWeather)
        updateSelectedData(hour: weatherFetcher.hourlyWeather[0])
    }
    
    
    func parseDate(jsonDate : Int) -> (String, String) {
        
            let date = NSDate(timeIntervalSince1970: TimeInterval(jsonDate))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, yyyy"
            let dateString = dateFormatter.string(from: date as Date)
        dateFormatter.dateFormat = "h a"
            let timeString = dateFormatter.string(from: date as Date)
            return(dateString, timeString)
       
    }
    
    func updateDataOnScreen(hourlyData : [HourWeather] ) {
        print("trying to update")
        for index in 0..<hourlyData.count {
            hourLabels[index].text = hourlyData[index].hour
            hourImageViews[index].image = UIImage(named: hourlyData[index].iconName)
        }
    }
    
    func updateSelectedData(hour: HourWeather) {
        dateLabel.text = "\(hour.dayDate) \(hour.hour)"
        selectedWeatherImageView.image = UIImage(named : hour.iconName)
        temperatureLabel.text = "\(hour.temperature)º F"
        summaryLabel.text = hour.summary
    }
}

