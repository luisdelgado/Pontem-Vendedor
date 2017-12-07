//
//  PrincipalViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/7/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth

class PrincipalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil) {
                print(user?.email)
            }
        }
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
