//
//  PredefinedColors.swift
//  Single View Demo 1
//
//  Created by Colin Howell on 12/6/16.
//  Copyright © 2016 Colin Howell. All rights reserved.
//

import UIKit

class PredefinedColors {
    
    // A type which defines the UIKit predefined colors and their names.
    
    struct PredefColor {
        let name: String
        let color: UIColor
    }

    static let colors = [PredefColor(name: "White",         color: UIColor.white),
                         PredefColor(name: "Light gray",    color: UIColor.lightGray),
                         PredefColor(name: "Gray",          color: UIColor.gray),
                         PredefColor(name: "Dark gray",     color: UIColor.darkGray),
                         PredefColor(name: "Black",         color: UIColor.black),
                         PredefColor(name: "Red",           color: UIColor.red),
                         PredefColor(name: "Orange",        color: UIColor.orange),
                         PredefColor(name: "Yellow",        color: UIColor.yellow),
                         PredefColor(name: "Green",         color: UIColor.green),
                         PredefColor(name: "Cyan",          color: UIColor.cyan),
                         PredefColor(name: "Blue",          color: UIColor.blue),
                         PredefColor(name: "Magenta",       color: UIColor.magenta),
                         PredefColor(name: "Purple",        color: UIColor.purple),
                         PredefColor(name: "Brown",         color: UIColor.brown),
                         PredefColor(name: "Clear",         color: UIColor.clear)]
}
