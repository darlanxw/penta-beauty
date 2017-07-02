//
//  Bid.swift
//  PentaBeauty
//
//  Created by MacDD02 on 02/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Bid {
    var id:String!
    var customerEmail:String!
    var dealerEmail:String!
    var orderId:String!
    var sendDate: String!
    var status:String!
    var value:String!
    var ref:FIRDatabaseReference?
    var key:String
    
    init(id: String, customerEmail: String, dealerEmail: String, orderId:String, sendDate:String, status: String, value: String, key: String = "") {
        self.id = id
        self.customerEmail = customerEmail
        self.dealerEmail = dealerEmail
        self.orderId = orderId
        self.sendDate = sendDate
        self.status = status
        self.value = value
        self.key = key
        self.ref = nil
       
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.id = snapshotValue["id"] as? String
        self.customerEmail = snapshotValue["customerEmail"] as? String
        self.orderId = snapshotValue["orderId"] as? String
        self.sendDate = snapshotValue["sendDate"] as? String
        self.status = snapshotValue["status"] as? String
        self.value = snapshotValue["value"] as? String
        self.dealerEmail = snapshotValue["dealerEmail"] as? String
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "customerEmail": customerEmail,
            "orderId": orderId,
            "sendDate": sendDate,
            "status": status,
            "value": value,
            "dealerEmail": dealerEmail
        ]
    }
}
