//
//  PostLoginViewController.swift
//  Drop
//
//  Created by Mike Mallow on 4/11/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase

class PostLoginViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    
    var name:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let user = FIRAuth.auth()!.currentUser
        print("user logged in")
//        self.userNameLabel.text = user!.email
        
        self.userNameLabel.text = name

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

    @IBAction func logout(_ sender: Any) {
        
        print("logout pushed")
        try! FIRAuth.auth()?.signOut()
        
        //self.navigationController?.tabBarController?.navigationController?.popViewController(animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(withIdentifier: "logIn")
        self.present(logIn, animated: true, completion: nil)
        
    }
}
