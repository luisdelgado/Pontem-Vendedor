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

    
    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBAction func entrar(_ sender: UIButton) {
        let email: String = usuario.text!
        let senhaString: String = senha.text!
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: senhaString) { (user, error) in
            if error == nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:"PrincipalID") as UIViewController
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                print(error.debugDescription)
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


}

