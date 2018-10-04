//
//  HourWeather.swift
//  Hourcast-IOS-11
//
//  Created by Nicholas Romano on 10/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import Foundation

class HourWeather {
    
    var dayDate : String
    var temperature : String
    var iconName : String
    var hour : String
    
    init(date: String, eventTime: String , temp: String, condition : String) {
        
        dayDate = date
        hour = eventTime
        iconName = condition
        let index = temp.index(temp.startIndex, offsetBy: 3)
        temperature = String(temp[...index])
        
    }
    
    
    func getTemp() -> String {
        var temp = Double(temperature)
        temp = (temp!)*(9.0/5.0) - 459.67
        return "\(temp!.rounded())º"
    }
    

}





