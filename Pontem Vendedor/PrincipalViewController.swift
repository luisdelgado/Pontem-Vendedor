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
    
    var produtosLocal: [String] = []
    
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
                        for (produto, _) in produtos! {
                            self.contadorProdutos = self.contadorProdutos + 1
                            if let keyDict = produtos![produto] as? NSDictionary {
                                if let produtoAtual = keyDict["productname"] as? String {
                                    self.produtosLocal.append(produtoAtual)
                                }
                            }
                        }
                    }
                    print(self.produtosLocal)
                }) { (error) in
                    print(error.localizedDescription)
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
