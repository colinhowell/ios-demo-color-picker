//
//  ViewController.swift
//  Single View Demo 1
//
//  Created by Colin Howell on 12/6/16.
//  Copyright © 2016 Colin Howell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Properties
    
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var topSliderNameLabel: UILabel!
    @IBOutlet weak var middleSliderNameLabel: UILabel!
    @IBOutlet weak var bottomSliderNameLabel: UILabel!
    @IBOutlet weak var alphaSliderNameLabel: UILabel!
    @IBOutlet weak var topSliderValueLabel: UILabel!
    @IBOutlet weak var middleSliderValueLabel: UILabel!
    @IBOutlet weak var bottomSliderValueLabel: UILabel!
    @IBOutlet weak var alphaSliderValueLabel: UILabel!
    @IBOutlet weak var topSlider: UISlider!
    @IBOutlet weak var middleSlider: UISlider!
    @IBOutlet weak var bottomSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var colorView: UIView!
    
    var colorModeIsHsb = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // We handle the needs of the color picker ourselves.
        colorPicker.delegate = self
        colorPicker.dataSource = self
        
        colorModeIsHsb = false

        topSliderNameLabel.text = "Red"
        middleSliderNameLabel.text = "Green"
        bottomSliderNameLabel.text = "Blue"
        alphaSliderNameLabel.text = "Alpha"

        let startColor = PredefinedColors.colors[0].color
        colorView.backgroundColor = startColor
        
        updateColorSliders(startColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UIPickerViewDelegate
    
    // What is the text label of a particular row on a particular component (wheel) of the picker?
    // For this picker, it's the name of the row's predefined color.
    // (We ignore "component" since there's only one.)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PredefinedColors.colors[row].name
    }

    // Respond to the selection of a particular row on a particular component (wheel) of the picker.
    // Set the color view's background color to the named color selected.
    // (We ignore "component" since there's only one.)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerColor = PredefinedColors.colors[row].color
        colorView.backgroundColor = pickerColor

        updateColorSliders(pickerColor)
    }
    
    func updateColorSliders(_ newColor: UIColor) {
        var alpha: CGFloat = 0

        if colorModeIsHsb {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            
            newColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            
            topSlider.setValue(Float(hue), animated: false)
            topSliderValueLabel.text = String(format: "%.03f", hue)
            middleSlider.setValue(Float(saturation), animated: false)
            middleSliderValueLabel.text = String(format: "%.03f", saturation)
            bottomSlider.setValue(Float(brightness), animated: false)
            bottomSliderValueLabel.text = String(format: "%.03f", brightness)
        }
        else {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            
            newColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            topSlider.setValue(Float(red), animated: false)
            topSliderValueLabel.text = String(format: "%.03f", red)
            middleSlider.setValue(Float(green), animated: false)
            middleSliderValueLabel.text = String(format: "%.03f", green)
            bottomSlider.setValue(Float(blue), animated: false)
            bottomSliderValueLabel.text = String(format: "%.03f", blue)
        }
        
        alphaSlider.setValue(Float(alpha), animated: false)
        alphaSliderValueLabel.text = String(format: "%.03f", alpha)
    }
    
    // MARK: UIPickerViewDataSource
    
    // How many components (separate spinning wheels) does our picker have?
    // In this case, we just have a single wheel.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // How many rows are there on a particular component (wheel) of a picker?
    // For this picker, it's the number of predefined colors.
    // (We ignore "component" since there's only one.)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PredefinedColors.colors.count
    }
    
    // MARK: Actions
    
    @IBAction func topSliderSet(_ sender: UISlider) {
        topSliderValueLabel.text = String(format: "%.03f", sender.value)
        sliderSetColor(sender.value, component: "comp1")
    }

    @IBAction func middleSliderSet(_ sender: UISlider) {
        middleSliderValueLabel.text = String(format: "%.03f", sender.value)
        sliderSetColor(sender.value, component: "comp2")
    }

    @IBAction func bottomSliderSet(_ sender: UISlider) {
        bottomSliderValueLabel.text = String(format: "%.03f", sender.value)
        sliderSetColor(sender.value, component: "comp3")
    }

    @IBAction func alphaSliderSet(_ sender: UISlider) {
        alphaSliderValueLabel.text = String(format: "%.03f", sender.value)
        colorView.backgroundColor = colorView.backgroundColor!.withAlphaComponent(CGFloat(sender.value))
    }
    
    func sliderSetColor(_ value: Float, component: String) {
        var comp1: CGFloat = 0
        var comp2: CGFloat = 0
        var comp3: CGFloat = 0
        var alpha: CGFloat = 0
        
        if colorModeIsHsb {
            colorView.backgroundColor!.getHue(&comp1, saturation: &comp2, brightness: &comp3, alpha: &alpha)
        }
        else {
            colorView.backgroundColor!.getRed(&comp1, green: &comp2, blue: &comp3, alpha: &alpha)
        }
        switch component {
        case "comp1":
            comp1 = CGFloat(value)
        case "comp2":
            comp2 = CGFloat(value)
        case "comp3":
            comp3 = CGFloat(value)
        default:
            break
        }
        if colorModeIsHsb {
            colorView.backgroundColor = UIColor(hue: comp1, saturation: comp2, brightness: comp3, alpha: alpha)
        }
        else {
            colorView.backgroundColor = UIColor(red: comp1, green: comp2, blue: comp3, alpha: alpha)
        }
    }
    
    @IBAction func switchColorMode(_ sender: UISwitch) {
        colorModeIsHsb = sender.isOn
        
        if colorModeIsHsb {
            topSliderNameLabel.text = "Hue"
            middleSliderNameLabel.text = "Saturation"
            bottomSliderNameLabel.text = "Brightness"
        }
        else {
            topSliderNameLabel.text = "Red"
            middleSliderNameLabel.text = "Green"
            bottomSliderNameLabel.text = "Blue"
        }

        updateColorSliders(colorView.backgroundColor!)
    }
}

