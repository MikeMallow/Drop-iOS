//
//  ScrollViewController.swift
//  Drop
//
//  Created by Mike Mallow on 4/25/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet weak var report1Label: UILabel!
    @IBOutlet weak var report2Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        report1Label.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
