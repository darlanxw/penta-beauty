//
//  SignUpTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 02/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import Firebase
import FirebaseDatabase

class SignUpTableViewController : UITableViewController {
    @IBOutlet var txtName:UITextField!
    @IBOutlet var txtAddress:UITextField!
    @IBOutlet var txtPassword:UITextField!
    @IBOutlet var txtConfirmPassword:UITextField!
    @IBOutlet var txtEmail:UITextField!
    
    
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func goToCreditCard(){
        let newUser = User(fullName: txtName.text!, email: txtEmail.text!, address: txtAddress.text!, password: txtPassword.text!, creditCard: nil)
        
        let resultTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreditCardTableViewController") as! CreditCardTableViewController
        resultTVC.user = newUser
        self.navigationController?.pushViewController(resultTVC, animated: true)
    }
}

class CreditCardTableViewController : UITableViewController {
    @IBOutlet var txtName:UITextField!
    @IBOutlet var txtNumber:UITextField!
    @IBOutlet var txtSince:UITextField!
    @IBOutlet var txtCvv:UITextField!
    
    var user:User!
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func createUser() -> Void {
        let ref = FIRDatabase.database().reference(withPath: "cadastro")
        
        user.creditCard = CreditCard(name: txtName.text!, number: txtNumber.text!, since: txtSince.text!, cvv: txtCvv.text!)
        // 3
        let revistinhaItemRef = ref.child(user.email.lowercased())
        
        // 4
        revistinhaItemRef.setValue(user.toAnyObject())
    }
}
