//
//  ViewController.swift
//  CustomEmailLogin
//
//  Created by Keneisha Wiggan on 8/24/19.
//  Copyright © 2019 Keneisha Wiggan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var signInButton: UIButton!
    
    //create a boolean to signify if the user signed in or not
    var isSignIn:Bool = true
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //flip the boolean
        isSignIn = !isSignIn
        
        //check the bool and set the button and labels
        if isSignIn{
            signInLabel.text = "Sign in"
            signInButton.setTitle("Sign In", for: .normal)
        }
        else {
            signInLabel.text = "Register"
            signInButton.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        //TODO: Do some form validation on the email and password
        if let email = emailTextField.text, let pass = passwordTextField.text{
            
            //Check if it's sign in or register
            if isSignIn{
                //sign in the user with Firebase
                Auth.auth().signIn(withEmail: email, password: pass) { [weak self] user, error in
            
                    //check that the user isn't nil
                    if let u = user {
                        
                        //User is found, go to home screen
                        self!.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else{
                        //Error: check error and show message
                    }
                }
            }
            else {
                //Register the user with Firebase
                Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                    // Check that user isn't nil
                    if let u = user{
                        //user is found, go to home screen
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    }
                    else {
                        //Error: check error and show message
                    }
        }
        }
    }

   
}
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        //Dismiss keyboard when the view is tapped on
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}
