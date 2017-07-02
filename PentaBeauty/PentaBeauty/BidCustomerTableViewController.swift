//
//  BidCustomerTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 02/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class BidCustomerTableViewController : UITableViewController {
    var order:Order!
    var bids:[Bid] = []
    var bidSelected:Bid!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        get()
    }
    
    func get(){
        let ref = FIRDatabase.database().reference(withPath: "oferta")
        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [Bid] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let groceryItem = Bid(snapshot: item as! FIRDataSnapshot)
                
                if (groceryItem.orderId == self.order.id && self.order.customerEmail == self.appDelegate.email) && (groceryItem.status != "4" && groceryItem.status != "3"){
                    newItems.append(groceryItem)
                }
            }
            
            // 5
            self.bids = newItems
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bids.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBid", for: indexPath ) as! CellBid
        
        cell.dealerDistance.text = "2km"
        cell.dealerEmail.text = bids[indexPath.row].dealerEmail
        cell.dealerName.text = "Darlan"
        cell.dealerValue.text = bids[indexPath.row].value
        cell.orderImage.downloadedFrom(link: order.link!)
        cell.dealerRating.text = "Excelente"
        
        if(bids[indexPath.row].status == "1"){
            cell.status.text = "Aberto"
        }else if(bids[indexPath.row].status == "2"){
            cell.status.text = "Negociação"
        }else if(bids[indexPath.row].status == "3"){
            cell.status.text = "Pago"
        }else if(bids[indexPath.row].status == "4"){
            cell.status.text = "Recusado"
        }else if(bids[indexPath.row].status == "5"){
            cell.status.text = "Entregue"
        }
        
        
        return cell
    }
    
    func accept(){
    
    }
    
    func reject(){
        
    }
    
    func sendBid(){
        let alert = UIAlertController(title: "Aviso", message: "Deseja confirmar essa proposta de oferta com o Cartão 6630 XXXX XXXX XXX?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.default, handler: { action in
            let ref = FIRDatabase.database().reference(withPath: "oferta")
            
            let revistinhaItemRef = ref.child(self.bidSelected.id)
            let data = ["customerEmail": self.bidSelected.customerEmail, "dealerEmail": self.bidSelected.dealerEmail, "status": "3", "orderId": self.bidSelected.orderId!, "value": self.bidSelected.value, "sendDate": self.bidSelected.sendDate, "id": self.bidSelected.id] as [String : Any]
            
            revistinhaItemRef.setValue(data)
            
            let refOrder = FIRDatabase.database().reference(withPath: "pedido")
            self.order.status = "3"
            let revistinhaItemRefOrder = refOrder.child(self.bidSelected.orderId)
            
            revistinhaItemRefOrder.setValue(self.order.toAnyObject())
            
            self.get()
            
            
            let alertSuccess = UIAlertController(title: "Aviso", message: "Compra realizada com sucesso, seu produto chegará em breve!", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alertSuccess.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                let finalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
                
                self.present(finalVC, animated: true, completion: nil)
            }))
            
            // show the alert
            self.present(alertSuccess, animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Rejeitar", style: UIAlertActionStyle.default, handler: { action in
            let ref = FIRDatabase.database().reference(withPath: "oferta")
            
            let revistinhaItemRef = ref.child(self.bidSelected.id)
            let data = ["customerEmail": self.bidSelected.customerEmail, "dealerEmail": self.bidSelected.dealerEmail, "status": "4", "orderId": self.bidSelected.orderId!, "value": self.bidSelected.value, "sendDate": self.bidSelected.sendDate, "id": self.bidSelected.id] as [String : Any]
            
            revistinhaItemRef.setValue(data)
            
            
            let alertSuccess = UIAlertController(title: "Aviso", message: "A oferta foi rejeitada com sucesso.", preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alertSuccess.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                let finalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
                
                self.present(finalVC, animated: true, completion: nil)
            }))
            
            // show the alert
            self.present(alertSuccess, animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        /*
       */
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bidSelected = bids[indexPath.row]
        sendBid()
    }
    
    //TODO
    //CLICA EM CIMA DO PRODUTO ABRE UM ALERT COM UM ACEITO E CONFIRMO
    //FAZ UPLOAD DA OFERTA E DO PEDIDO, ALTERANDO OFERTA E PEDIDO PRA 2
}
