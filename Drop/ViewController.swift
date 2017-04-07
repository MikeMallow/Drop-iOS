//
//  ViewController.swift
//  Drop
//
//  Created by Mike Mallow on 2/13/17.
//  Copyright © 2017 Mike Mallow. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailTextField: UIDesignableTextField!
    @IBOutlet weak var passwordTextField: UIDesignableTextField!
    @IBOutlet weak var logoutButton: UILabel!
    
    
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
        print("correct view loaded")
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser {
            print("user logged in")
            self.logoutButton.alpha = 1.0
            self.usernameLabel.text = user.email
        } else {
            print("no user logged in")
            self.logoutButton.alpha = 0.0
            self.usernameLabel.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        print("login button pushed")
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter and email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                
                if error == nil
                {
                    self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            })
        }

    }
    
    @IBAction func logoutAction(_ sender: AnyObject)
    {
        print("logout pushed")
        try! FIRAuth.auth()?.signOut()
        self.logoutButton.alpha = 0.0
        self.usernameLabel.text = ""
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }

}


