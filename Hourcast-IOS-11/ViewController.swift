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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let stacks = hourStacks {
           for stack in stacks {
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hourTapped(tapGestureRecognizer:)))
                stack.isUserInteractionEnabled = true
                stack.addGestureRecognizer(tapGestureRecognizer)
            }
        } else {
            print("Error Hour Stacks were not linked properly")
        }
    }
    
    @objc func hourTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedStack = tapGestureRecognizer.view as! UIStackView
        if let index = hourStacks?.index(of: tappedStack) {
            print(index)
        } else {
            print("Error with stack linkage")
            
        }
        // Your action
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

