//
//  CriarViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/5/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CriarViewController: UIViewController {
    
    var userId: String = ""
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        let email: String = self.emailField.text!
        let password: String = self.passwordField.text!
        let name: String = self.nameField.text!
        let phone: String = self.phoneField.text!
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.userId = (user?.uid)!
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("users/\(self.userId)").child("name").setValue(name)
                ref.child("users/\(self.userId)").child("email").setValue(email)
                ref.child("users/\(self.userId)").child("phone").setValue(phone)
                if self.shouldPerformSegue(withIdentifier: "CriarID", sender: self) {
                    self.performSegue(withIdentifier: "CriarID", sender: self)
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
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any!) -> Bool {
        return self.userId != ""
    } 
}
