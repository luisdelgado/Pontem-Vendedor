//
//  PrincipalViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/7/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class PrincipalViewController: UIViewController, UITableViewDelegate {
    
    var products: [String] = []
    var productCount: Int = 0
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil) {
                let userID = Auth.auth().currentUser?.uid
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let name = value?["name"] as? String ?? ""
                    self.name.text = name
                    let products = value?["produtos"] as? NSDictionary
                    if products != nil {
                        for (productId, _) in products! {
                            self.productCount = self.productCount + 1
                            if let product = products![productId] as? NSDictionary {
                                if let productName = product["name"] as? String {
                                    self.products.append(productName)
                                }
                            }
                        }
                    }
                }) { (error) in
                }
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
