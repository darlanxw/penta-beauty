    //
//  MyOrderCusotmerTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 02/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class MyOrderCustomerTableViewController : UITableViewController {
    var orders:[Order] = []
    let ref = FIRDatabase.database().reference(withPath: "pedido")
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [Order] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let groceryItem = Order(snapshot: item as! FIRDataSnapshot)
                
                if groceryItem.customerEmail == self.appDelegate.email {
                    newItems.append(groceryItem)
                }
            }
            
            // 5
            self.orders = newItems
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOrder", for: indexPath ) as! CellOrder
        
        cell.productTitle.text = orders[indexPath.row].productTitle
        cell.clientName.text = orders[indexPath.row].customerName
        cell.date.text = orders[indexPath.row].date
        cell.productImage.downloadedFrom(link: orders[indexPath.row].link!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let bidCustomerTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BidCustomerTableViewController") as! BidCustomerTableViewController
        bidCustomerTVC.order = orders[indexPath.row]
        self.navigationController?.pushViewController(bidCustomerTVC, animated: true)
    }
}
