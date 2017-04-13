//
//  RegisterViewController.swift
//  Drop
//
//  Created by Mike Mallow on 3/3/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseDatabase


class RegisterViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    

    @IBOutlet weak var nameTextField: UIDesignableTextField!
    @IBOutlet weak var emailTextField: UIDesignableTextField!
    @IBOutlet weak var passwordTextField: UIDesignableTextField!
    
    
    @IBOutlet weak var userButton: RoundButton!
    @IBOutlet weak var workerButton: RoundButton!
    @IBOutlet weak var managerButton: RoundButton!
    @IBOutlet weak var adminButton: RoundButton!

    var accountType = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("Register screen loaded")
        
        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func userButtonSelect(_ sender: Any) {
        
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
    
    //Function for creating an account
    //FireBase does all of the heavy lifting and errors are automatically generated
    
    @IBAction func alreadyMemberButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAcount(_ sender: Any) {
         if emailTextField.text == "" || passwordTextField.text == ""
         {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
         }
        
        let userEmail: String = self.emailTextField.text!
        let userPassword: String = self.passwordTextField.text!
        let userName: String = self.nameTextField.text!
        
        if userName == "" && self.accountType == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please give your name and choose and account type.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if userName == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please give your name.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
            
        else if self.accountType == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please choose an account Type.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
            
            
        else
         {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error)  in
                if error == nil {
                
                    //TODO
                    // Figure out how to log in from here. Probably after hitting "Loging" on the alert it logs you in automatically
                    
                    
                    // successful account creation after all of the fields are filled in properly
                    
                    let userID: String = user!.uid
                        
                    self.ref.child("users").child(userID).setValue(["_email": userEmail, "_name": userName, "_password": userPassword, "_usertype": self.accountType])
                        
                    let alertController = UIAlertController(title: "Yay! Account Created!", message: "Please log in.", preferredStyle: .alert)
                        
                    let defaultAction = UIAlertAction(title: "Login", style: .cancel, handler: { alert in
                        
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                        
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let postLoginViewController = storyboard.instantiateViewController(withIdentifier: "loggedIn")
//                        self.present(postLoginViewController, animated: true, completion: nil)
                    })
                    
                    alertController.addAction(defaultAction)
                        
                    self.present(alertController, animated: true, completion: nil )}

                    
                else {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                
                    self.present(alertController, animated: true, completion: nil)

                
                }
            })
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //SEGUE
        //you can pass variables from this controller to the next here
        if (segue.identifier == "loginSegue") {
            //            let destination = segue.destination
            //You cannot modify UI IBOutlets here, it will get overriden by loadView()
            //            destination.name = "Bob Waters"
        }
    }

}
