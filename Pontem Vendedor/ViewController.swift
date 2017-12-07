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
    
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBAction func entrar(_ sender: UIButton) {
        let email: String = usuario.text!
        let senhaString: String = senha.text!
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: senhaString) { (user, error) in
            if error == nil {
                self.userId = (user?.uid)!
                if self.shouldPerformSegue(withIdentifier: "EntrarID", sender: self) {
                    self.performSegue(withIdentifier: "EntrarID", sender: self.userId)
                }
            } else {
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    @IBAction func criarConta(_ sender: UIButton) {
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
        return self.userId != ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EntrarID") {
            let user = segue.destination as! PrincipalViewController
            user.userId = self.userId
        }
    }
}

