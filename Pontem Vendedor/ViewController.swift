//
//  ViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/5/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    var userId: String = ""
    
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signIn(_ sender: Any) {
        let email: String = self.emailField.text!
        let password: String = self.passwordField.text!
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.userId = (user?.uid)!
                if self.shouldPerformSegue(withIdentifier: "EntrarID", sender: self) {
                    self.performSegue(withIdentifier: "EntrarID", sender: self)
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any!) -> Bool {
        if identifier == "EntrarID" {
            return self.userId != ""
        }
        return true
    }
}

