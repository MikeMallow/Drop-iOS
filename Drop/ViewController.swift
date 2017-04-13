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
    
    //@IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailTextField: UIDesignableTextField!
    @IBOutlet weak var passwordTextField: UIDesignableTextField!
    
    
    
    
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
        if (FIRAuth.auth()?.currentUser) != nil {
            print("user logged in")
            
            // Got to ask B-Rizzle why this doens't work
            // it should immediately go to the loggedIN view is a user is already signed in, but it doesn't
            // Fixed it by moving it to viewDidAppear (below)
            
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let postLoginViewController = storyboard.instantiateViewController(withIdentifier: "loggedIn")
//            self.present(postLoginViewController, animated: true, completion: nil)
            
            
        } else {
            print("no user logged in")
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FIRAuth.auth()?.currentUser) != nil {
            self.performSegue(withIdentifier: "loginSegue", sender: self)

//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let postLoginViewController = storyboard.instantiateViewController(withIdentifier: "loggedIn")
//            self.present(postLoginViewController, animated: true, completion: nil)
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
                    
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
//                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                    let postLoginViewController = storyboard.instantiateViewController(withIdentifier: "loggedIn")
//                    self.present(postLoginViewController, animated: true, completion: nil)
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
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }

    @IBAction func forgotPassword(_ sender: Any) {
        
        if self.emailTextField.text == ""
        {
            let alertController = UIAlertController(title: "Oops!", message: "Please enter your email address.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.sendPasswordReset(withEmail: self.emailTextField.text!, completion: { (error) in
                
                var title = ""
                var message = ""
                
                if error != nil {
                    title = "Oops!"
                    message = (error?.localizedDescription)!
                }
                
                else {
                    title = "Success"
                    message = "Password reset email sent"
                    self.emailTextField.text = ""
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
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























