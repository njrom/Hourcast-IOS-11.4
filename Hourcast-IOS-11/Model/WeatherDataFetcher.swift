//
//  WeatherDatafetcher.swift
//  Hourcast-IOS-11
//
//  Created by Nicholas Romano on 10/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherDataFetcher {
    
    var hourlyWeather = [HourWeather]()
    
    func fetchWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(response.result.error!)")
            }
        }
    }
    // Parses the weather data and returns required HourWeather Array
    func updateWeatherData(json : JSON) {
        
        let hour0JSON = json["list"][0]
        
        hourlyWeather.append(HourWeather(date: <#T##String#>, eventHour: , temp: <#T##String#>, highNum: <#T##String#>, lowNum: <#T##String#>, condition: <#T##Int#>))
        let hour1JSON = json["list"][1]
        
        hourlyWeather.append(HourWeather(date: <#T##String#>, eventHour: , temp: <#T##String#>, highNum: <#T##String#>, lowNum: <#T##String#>, condition: <#T##Int#>))
        let hour2JSON = json["list"][2]
        
        hourlyWeather.append(HourWeather(date: <#T##String#>, eventHour: , temp: <#T##String#>, highNum: <#T##String#>, lowNum: <#T##String#>, condition: <#T##Int#>))
        let hour3JSON = json["list"][3]
        
        hourlyWeather.append(HourWeather(date: <#T##String#>, eventHour: , temp: <#T##String#>, highNum: <#T##String#>, lowNum: <#T##String#>, condition: <#T##Int#>))
        
    }
    
    func parseDate(jsonDate : String) -> (String, String) {
        
        return (date, time)
    }
}
