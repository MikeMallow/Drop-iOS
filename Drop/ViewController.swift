//
//  ViewController.swift
//  Drop
//
//  Created by Mike Mallow on 2/13/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Prevent AutoRotation to landscape by overriding two variables - Mike M
    // Variables overrided are immediately below these comments
    // You can add this to any ViewController to lock it in portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

