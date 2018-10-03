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
    var high : String
    var low : String
    var temperature : String
    var iconCondition : Int
    
    init(name: String, date: String, temp: String, highNum : String, lowNum : String, condition : Int) {
        
        dayDate = date
        high = highNum
        low = lowNum
        iconCondition = condition
        temperature = temp
        
    }
    
    func getIcon() -> String {
        switch (iconCondition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
    
    func getTemp() -> String {
        let temp = tempToF(tempString: temperature)
        let tempHigh = tempToF(tempString: high)
        let tempLow = tempToF(tempString: low)
        return "\(temp)"
    }
    
    func tempToF(tempString: String) -> String {
        var temp = Double(tempString)
        temp = (temp!)*(9.0/5.0) - 459.67
        return "\(temp!.rounded())º"
    }
    
    func readJSON

}





