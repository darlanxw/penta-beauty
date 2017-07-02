//
//  MyOrderDealerTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit

class MyOrderDealerTableViewController : UITableViewController {
    var orders:[Order] = []

    override func viewDidLoad() {
        self.navigationItem.title = "Meus pedidos"
        loadOrder()
    }
    
    func loadOrder(){
        let newOrder4:Order = Order(id: "", productTitle: "Creme Natura", customerEmail: "", dealerEmail: "", date: Date(), customerName: "Darlan Borges", dealerName: "Bruna Alcantar", query: "", link: "", status: "")
        orders.append(newOrder4)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOrder", for: indexPath ) as! CellOrder
        print(orders[indexPath.row].dealerName)
        cell.clientName.text = orders[indexPath.row].customerName
        cell.productTitle.text = orders[indexPath.row].productTitle
        cell.date.text = "\(orders[indexPath.row].date)"
        
        return cell
    }
}
