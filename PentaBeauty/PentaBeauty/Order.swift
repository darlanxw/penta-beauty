//
//  Order.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Order {
    var id:String?
    var productTitle:String?
    var customerName:String?
    var customerEmail:String?
    var dealerEmail:String?
    var dealerName:String?
    var date:String
    var query:String?
    var link:String?
    var status:String?
    var ref: FIRDatabaseReference?
    var key: String
    
    init(id:String?, productTitle: String?, customerEmail:String?, dealerEmail: String?, date: Date, customerName: String?, dealerName: String?, query: String?, link: String?, status: String?, key: String = "") {
        self.id = id ?? ""
        self.productTitle = productTitle ?? ""
        self.customerEmail = customerEmail ?? ""
        self.dealerEmail = dealerEmail ?? ""
        self.date = "\(date)"
        self.customerName = customerName ?? ""
        self.dealerName = dealerName ?? ""
        self.query = query ?? ""
        self.link = link ?? ""
        self.status = status ?? ""
        self.ref = nil
        self.key = key
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        self.id = id ?? snapshotValue["id"] as! String
        self.productTitle = snapshotValue["productTitle"] as? String
        self.customerEmail = snapshotValue["customerEmail"] as? String
        self.dealerEmail = snapshotValue["dealerEmail"] as? String
        self.date = snapshotValue["date"] as! String
        self.customerName = snapshotValue["customerName"] as? String
        self.dealerName = snapshotValue["dealerName"] as? String
        self.query = snapshotValue["query"] as? String
        self.link = snapshotValue["link"] as? String
        self.status = snapshotValue["status"] as? String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "productTitle": productTitle,
            "customerName": customerName,
            "customerEmail": customerEmail,
            "dealerEmail": dealerEmail,
            "dealerName": dealerName,
            "date": date,
            "query": query,
            "link": link,
            "status": status
        ]
    }
}
