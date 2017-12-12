//
//  ProdutoViewController.swift
//  Pontem Vendedor
//
//  Created by Luís Henrique Delgado Santos on 12/9/17.
//  Copyright © 2017 Luís Henrique Delgado Santos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProdutoViewController: UIViewController {
    
    var categorias: [String] = []

    @IBOutlet weak var nomeProduto: UITextField!
    @IBOutlet weak var precoProduto: UITextField!
    @IBOutlet weak var categoriaProduto: UITextField!
    @IBAction func cadastrarProduto(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil) {
                let userID = Auth.auth().currentUser?.uid
                var ref: DatabaseReference!
                ref = Database.database().reference()
                let productKey = ref.child("users/\(userID!)/produtos/").childByAutoId().key
                ref.child("users/\(userID!)/produtos/\(productKey)").child("productname").setValue(self.nomeProduto.text)
                ref.child("users/\(userID!)/produtos/\(productKey)").child("productprice").setValue(self.precoProduto.text)
                ref.child("users/\(userID!)/produtos/\(productKey)").child("productcategory").setValue(self.categoriaProduto.text)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
