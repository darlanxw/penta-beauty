//
//  MyOrderDealerTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class OpportunitiesTableViewController : UITableViewController {
    var orders:[Order] = []
    let ref = FIRDatabase.database().reference(withPath: "pedido")
    let refOferta = FIRDatabase.database().reference(withPath: "oferta")
    var orderSelected:Order!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func getData(){
        ref.observe(.value, with: { snapshot in
            var newItems: [Order] = []
            
            // 3
            var groceryItem:Order!
            for item in snapshot.children {
                // 4
                groceryItem = Order(snapshot: item as! FIRDataSnapshot)
                //(toValue: groceryItem.id, childKey: "id")
                newItems.append(groceryItem)
                self.orders = newItems
                self.tableView.reloadData()
            }
            
            self.refOferta.observeSingleEvent(of: .value, with: { (snapShot) in
                
                if let snapDict = snapShot.value as? [String:AnyObject]{
                    
                    for each in snapDict{
                        let key  = each.key
                        let email = each.value["dealerEmail"] as! String
                        let orderId = each.value["orderId"] as! String
                        let status = each.value["status"] as! String
                        var count = 0
                        for item in newItems{
                            
                            if item.status == "1" && (email == self.appDelegate.email && orderId == item.id) {
                                print(item)
                                newItems.remove(at: count)
                                
                            }else{
                                
                            }
                            count += 1
                        }
                    }
                    
                    self.orders = newItems
                    self.tableView.reloadData()
                    
                }
            }, withCancel: {(Err) in
                
                print(Err.localizedDescription)
                
            })
            
            // 5
            self.tableView.reloadData()
            
        })
    }
    override func viewDidLoad() {
        getData()
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
        if orders[indexPath.row].status == "1" || orders[indexPath.row].status == "2" {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Oferta",
                                                message: "Batom Avon Rosa",
                                                preferredStyle: .alert)
            
            var alertSuccessController = UIAlertController(title: "Aviso",
                                                           message: "Oferta enviada com sucesso!",
                                                           preferredStyle: .alert)
            
            alertController!.addTextField(
                configurationHandler: {(textField: UITextField!) in
                    textField.placeholder = "Valor R$"
            })
            
            alertController!.addTextField(
                configurationHandler: {(textField: UITextField!) in
                    textField.placeholder = "Data de Entrega"
            })
            
            let action = UIAlertAction(title: "Enviar",
                                       style: UIAlertActionStyle.default,
                                       handler: {[weak self]
                                        (paramAction:UIAlertAction!) in
                                        if let textFields = alertController?.textFields{
                                            let theTextFields = textFields as [UITextField]
                                            let value = theTextFields[0].text
                                            let sendDate = theTextFields[1].text
                                            self?.orderSelected = self?.orders[indexPath.row]
                                            self?.sendBid(value: value!, sendDate: sendDate!)
                                        }
            })
            
            let action2 = UIAlertAction(title: "Recusar Oferta",
                                        style: UIAlertActionStyle.default,
                                        handler: {[weak self]
                                            (paramAction:UIAlertAction!) in
                                            if let textFields = alertController?.textFields{
                                                self?.orderSelected = self?.orders[indexPath.row]
                                                self?.sendRecuseBid()
                                            }
            })
            
            let actionSuccess = UIAlertAction(title: "Ok",
                                              style: UIAlertActionStyle.default,
                                              handler: {[weak self]
                                                (paramAction:UIAlertAction!) in
                                                if let textFields = alertController?.textFields{
                                                }
            })
            
            alertController?.addAction(action)
            alertController?.addAction(action2)
            alertSuccessController.addAction(actionSuccess)
            
            self.present(alertController!,
                         animated: true,
                         completion: nil)
            
            self.present(alertSuccessController,
                         animated: true,
                         completion: nil)
        }
    }
    
    func sendBid(value: String, sendDate: String){
        let ref = FIRDatabase.database().reference(withPath: "oferta")
        let id = UUID().uuidString
        let revistinhaItemRef = ref.child(id)
        let data = ["customerEmail": orderSelected.customerEmail!, "dealerEmail": appDelegate.email, "status": "2", "orderId": orderSelected.id!, "value": value, "sendDate": sendDate, "id": id] as [String : Any]
            
        revistinhaItemRef.setValue(data)
        getData()
    }
    
    func sendRecuseBid(){
        let ref = FIRDatabase.database().reference(withPath: "oferta")
        let id = UUID().uuidString
        let revistinhaItemRef = ref.child(id)
        let data = ["customerEmail": orderSelected.customerEmail!, "dealerEmail": appDelegate.email, "status": "4", "orderId": orderSelected.id!, "value": "0,0", "sendDate": "\(Date())", "id": id] as [String : Any]
        
        revistinhaItemRef.setValue(data)
        getData()
    }
}
