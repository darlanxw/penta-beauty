//
//  ViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FirebaseDatabase
import Firebase

class ViewController: UIViewController {

    @IBOutlet var txtSearch:UITextField!
    
    var customerAPI:CustomerAPI!
    var products:[Product] = []
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customerAPI = CustomerAPI()
        
        
        let logo = UIImage(named: "Fontenew.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        hideKeyboardWhenTappedAround()
        
        
       
    }
    
    @IBAction func searchProducts(){
        let query = txtSearch.text
        customerAPI.getImages(query: query!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, withCompletionHandler: { (resp) in
            self.products = resp
            self.goToResult()
        })
    }

    func goToResult(){
        let resultTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ResultImageTableViewController") as! ResultImageTableViewController
        let order = Order(id: UUID().uuidString, productTitle: txtSearch.text!, customerEmail: appDelegate.email, dealerEmail: nil, date: Date(), customerName: appDelegate.name, dealerName: nil, query: txtSearch.text!, link: nil, status: "1")
        resultTVC.products = products
        resultTVC.order = order
        resultTVC.searchName = txtSearch.text!
        self.navigationController?.pushViewController(resultTVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

