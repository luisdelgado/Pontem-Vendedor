//
//  CriarViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/5/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth

class CriarViewController: UIViewController {

    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBAction func criarContaVendedor(_ sender: UIButton) {
        let email: String = usuario.text!
        let senhaString: String = senha.text!
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: senhaString) { (user, error) in
            if error == nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier:"PrincipalID") as UIViewController
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
