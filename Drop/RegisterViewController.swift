//
//  RegisterViewController.swift
//  Drop
//
//  Created by Mike Mallow on 3/3/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit
import Firebase

//UIPickerViewDataSource, UIPickerViewDelegate

class RegisterViewController: UIViewController {

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
    
    //TODOs 
    
    @IBAction func createAcount(_ sender: Any) {
         if emailTextField.text == "" || passwordTextField.text == ""
         {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
         }
        else
         {
            FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(user, error)  in
                if error == nil {
                
                    let alertController = UIAlertController(title: "Yay! Account Created!", message: "Please log in.", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Login", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    //TODO
                    // Figure out how to log in from here. Probably after hitting "Loging" on the alert it logs you in automatically
                    
                }
                else {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                
                    self.present(alertController, animated: true, completion: nil)

                
                }
            })
        }
    }

}
