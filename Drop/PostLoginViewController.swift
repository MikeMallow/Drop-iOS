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


    @IBOutlet weak var userNameField: UIDesignableTextField!
    @IBOutlet weak var userEmailField: UIDesignableTextField!
    @IBOutlet weak var userPasswordField1: UIDesignableTextField!
    @IBOutlet weak var userPasswordConfirmField: UIDesignableTextField!
    @IBOutlet weak var userButton: RoundButton!
    @IBOutlet weak var workerButton: RoundButton!
    @IBOutlet weak var managerButton: RoundButton!
    @IBOutlet weak var adminButton: RoundButton!
    
    //Not the var name here is actually the user email passed in buy the login viewController. That was an experiment on navigation controllers or something
    var name:String!
    
    //The important variables
    var userEmail:String!
    var userName: String!
    var accountType: String!
    var ref: FIRDatabaseReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()!.currentUser
        print("user logged in")
//        self.userNameLabel.text = user!.email
        
        
        let userID: String = user!.uid
        
        self.ref.child("users").child(userID).observe(.value, with: { (snapshot) -> Void in
            print(snapshot.value as! NSDictionary)
            
            self.userName = (snapshot.value as! NSDictionary)["_name"] as! String
            self.accountType = (snapshot.value as! NSDictionary)["_userType"] as! String
        
            print(self.userName)
            print(self.accountType)
            
            // Needed to stick this here because firebase response too slow, so this code will excuted before firebase returns the user details
            self.userNameField.attributedPlaceholder = NSAttributedString(string: "name:  " + self.userName!, attributes: [NSForegroundColorAttributeName: UIColor.white])

            
            if self.accountType == "User" {
                self.userButton.backgroundColor = UIColor.gray
            } else if self.accountType == "Worker" {
                self.userButton.backgroundColor = UIColor.gray
            } else if self.accountType == "Manager" {
                self.userButton.backgroundColor = UIColor.gray
            } else {
                self.adminButton.backgroundColor = UIColor.gray
                }
            })
        
        print(self.userName)
        // setting and formatting formatting textField placeholders
        //self.userNameLabel.text = name
        userEmailField.attributedPlaceholder = NSAttributedString(string: "email:  " + user!.email!, attributes: [NSForegroundColorAttributeName: UIColor.white])

        
        
        
        

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

    @IBAction func updateInfoPressed(_ sender: Any) {
        //TODO
        //Update user info here
        //This should be fun, but it's 3:30 in the morning so I'll finish it later
    }

    
    @IBAction func userButtonSelect(_ sender: Any) {
        
        print("hi")
        accountType = "user"
        userButton.backgroundColor = UIColor.gray
        
        workerButton.backgroundColor = nil
        managerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func workerButtonSelect(_ sender: Any) {
        
        accountType = "worker"
        workerButton.backgroundColor = UIColor.gray
        
        userButton.backgroundColor = nil
        managerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func managerButtonSelect(_ sender: Any) {
        
        accountType = "manager"
        managerButton.backgroundColor = UIColor.gray
        
        userButton.backgroundColor = nil
        workerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func adminButtonSelect(_ sender: Any) {
        
        accountType = "admin"
        adminButton.backgroundColor = UIColor.gray
        
        userButton.backgroundColor = nil
        workerButton.backgroundColor = nil
        managerButton.backgroundColor = nil
        
    }

    @IBAction func cancelPressed(_ sender: Any) {
        //Not sure what to do here yet
        //May just reset the fields
        //May back out of this toolbar item 
        //Maybe I should set this one up like jaydens, who knows
        print("hi Mike, cancel was pressed")
    }
    
    @IBAction func roungLogOutPressed(_ sender: Any) {
        print("logout pushed")
        try! FIRAuth.auth()?.signOut()
        
        //self.navigationController?.tabBarController?.navigationController?.popViewController(animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(withIdentifier: "logIn")
        self.present(logIn, animated: true, completion: nil)

    }
}
