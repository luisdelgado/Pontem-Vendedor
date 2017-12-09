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
    
    var productname: String = ""
    var contadorProdutos: Int = 0
    var temAtual: String = ""
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var adicionarProduto: UIButton!
    
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
                    let useremail = value?["useremail"] as? String ?? ""
                    self.userEmail.text = useremail
                    let produtos = value?["produtos"] as? NSDictionary
                    if produtos != nil {
                        for (produto1, _) in produtos! {
                            self.contadorProdutos = self.contadorProdutos + 1
                            if let keyDict = produtos![produto1] as? NSDictionary {
                                if let imageURL = keyDict["productname"] as? String {
                                    self.productname.append(imageURL)
                                }
                                print(self.productname)
                            }
                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            } else {
                
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contadorProdutos
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
