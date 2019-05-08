//
//  ViewController.swift
//  VibrationTest
//
//  Created by hiroki on 2016/05/31.
//  Copyright © 2016年 hiroki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "\(slider.value)"
    }

    @IBAction func slide(_ sender: Any) {
        label.text = "\(slider.value)"
    }
    
    @IBAction func vibrate() {
        VibrationController.startVibration(withDuration: Double(slider.value))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

