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
import FirebaseStorage

class ProdutoViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var isVeganField: UISwitch!
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBAction func cadastrarProduto(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if (user != nil) {
                let userID = Auth.auth().currentUser?.uid
                var ref: DatabaseReference!
                ref = Database.database().reference()
                
                let productKey = ref.child("users/\(userID!)/products/").childByAutoId().key
                
                let storageRef = Storage.storage().reference().child("images/\(userID!)/products/\(productKey)")
                
                let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
                    guard let metadata = metadata else {
                        // Uh-oh, an error occurred!
                        return
                    }
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata.downloadURL
                }
                
                ref.child("users/\(userID!)/products/\(productKey)").child("name").setValue(self.nameField.text)
                ref.child("users/\(userID!)/products/\(productKey)").child("price").setValue(self.priceField.text)
                ref.child("users/\(userID!)/products/\(productKey)").child("category").setValue(self.categoryField.text)
                ref.child("users/\(userID!)/products/\(productKey)").child("vegan").setValue(self.isVeganField.isOn)
            }
        }
    }
    
    @IBAction func pickImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
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

extension ProdutoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Sem Imagem")
        }
        
        self.imagePreview.image = pickedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
