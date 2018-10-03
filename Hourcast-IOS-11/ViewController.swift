//
//  ViewController.swift
//  Hourcast-IOS-11
//
//  Created by Nicholas Romano on 10/2/18.
//  Copyright © 2018 Nicholas Romano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets for Selected Hours Weather 
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedWeatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // IBOutlets for Hourly Stack
    @IBOutlet var hourImageViews : [UIImageView]!
    @IBOutlet var hourLabels : [UILabel]!
    @IBOutlet var hourStacks : [UIStackView]!
    
    
    var hourlyWeather = [HourWeather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    
}

