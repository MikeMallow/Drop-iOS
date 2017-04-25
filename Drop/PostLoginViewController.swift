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
    var accountTypeChange: String!
    var ref: FIRDatabaseReference!
    var userID: String!
    var changeTypeBool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
        
        let user = FIRAuth.auth()!.currentUser
        print("user logged in")
//        self.userNameLabel.text = user!.email
        
        
        self.userID = user!.uid
        
        self.ref.child("users").child(userID).observe(.value, with: { (snapshot) -> Void in
            print(snapshot.value as! NSDictionary)
            
            self.userName = (snapshot.value as! NSDictionary)["_name"] as! String
            self.accountType = (snapshot.value as! NSDictionary)["_userType"] as! String
            if !self.changeTypeBool {
                self.accountTypeChange = self.accountType
            }
        
            print(self.userName)
            print(self.accountType)
            
            // Needed to stick this here because firebase response too slow, so this code will excuted before firebase returns the user details
            self.userNameField.attributedPlaceholder = NSAttributedString(string: "name:  " + self.userName!, attributes: [NSForegroundColorAttributeName: UIColor.white])

            if !self.changeTypeBool {
                if self.accountType == "user" {
                    self.userButton.backgroundColor = UIColor.gray
                    print("test2")
                } else if self.accountType == "worker" {
                    self.workerButton.backgroundColor = UIColor.gray
                } else if self.accountType == "manager" {
                    self.managerButton.backgroundColor = UIColor.gray
                } else {
                    self.adminButton.backgroundColor = UIColor.gray
                    print("mike is gay")
                    }
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
        
        let prntRef  = FIRDatabase.database().reference().child("users").child(self.userID)
        
        if self.userNameField.text != "" {
            prntRef.updateChildValues(["_name": userNameField.text!])
            self.userNameField.text = ""
            self.userNameField.attributedPlaceholder = NSAttributedString(string: "name:  " + self.userName!, attributes: [NSForegroundColorAttributeName: UIColor.white])
            
            }
        
        if self.accountTypeChange != self.accountType {
            prntRef.updateChildValues(["_userType": self.accountTypeChange])
            self.accountType = self.accountTypeChange
            if self.accountTypeChange == "user" {
                userButton.backgroundColor = UIColor.darkGray
            }
            if self.accountTypeChange == "worker" {
                workerButton.backgroundColor = UIColor.darkGray
            }
            if self.accountTypeChange == "manager" {
                managerButton.backgroundColor = UIColor.darkGray
            }
            if self.accountTypeChange == "admin" {
                adminButton.backgroundColor = UIColor.darkGray
            }
            
        }
        
        if self.userEmailField.text != "" {
            
        }
            
        
        
//        if self.userNameField.text != "" {
//            let prntRef  = FIRDatabase.database().reference().child("users").child(self.userID)
//            prntRef.updateChildValues(["_name": userNameField.text!])
//        
//        }
        
    }

    
    @IBAction func userButtonSelect(_ sender: Any) {
        
        self.accountTypeChange = "user"
        changeTypeBool = true
        userButton.backgroundColor = UIColor.gray
        print("test 1")
        
        workerButton.backgroundColor = nil
        managerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func workerButtonSelect(_ sender: Any) {
        
        self.accountTypeChange = "worker"
        changeTypeBool = true
        workerButton.backgroundColor = UIColor.gray
        
        userButton.backgroundColor = nil
        managerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func managerButtonSelect(_ sender: Any) {
        
        self.accountTypeChange = "manager"
        changeTypeBool = true
        managerButton.backgroundColor = UIColor.gray
        
        userButton.backgroundColor = nil
        workerButton.backgroundColor = nil
        adminButton.backgroundColor = nil
        
    }
    
    @IBAction func adminButtonSelect(_ sender: Any) {
        
        self.accountTypeChange = "admin"
        changeTypeBool = true
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
