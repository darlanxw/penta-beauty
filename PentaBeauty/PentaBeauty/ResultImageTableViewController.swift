//
//  ResultImageTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class ResultImageTableViewController : UITableViewController {
    var products:[Product] = []
    var searchName:String!
    var order:Order!
    var currentImage:String!
    
    override func viewDidLoad() {
        print(products)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellResultImage", for: indexPath ) as! CellResultImage
        
        cell.accessoryType = cell.isSelected ? .checkmark : .none
        cell.selectionStyle = .none
        
        cell.productImage.downloadedFrom(link: products[indexPath.row].url)
        cell.title.text = products[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        currentImage = products[indexPath.row].url
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func sendOrderRequest(){
        order.link = currentImage
        print(order)
        
        let ref = FIRDatabase.database().reference(withPath: "pedido")
        
        // 3
        let revistinhaItemRef = ref.child(order.id!)
        
        // 4
        revistinhaItemRef.setValue(order.toAnyObject())
        
        let finalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FinalViewController") 
        
        present(finalVC, animated: true, completion: nil)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
