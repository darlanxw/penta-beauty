//
//  User.swift
//  PentaBeauty
//
//  Created by MacDD02 on 02/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation

class User {
    var fullName:String!
    var email:String!
    var address:String!
    var password:String!
    var creditCard:CreditCard!
    
    init(fullName: String, email: String, address: String, password: String, creditCard:CreditCard?) {
        self.fullName = fullName
        self.email = email
        self.address = address
        self.password = password
        if let myCreditCard = creditCard {
            self.creditCard = myCreditCard
        }
    }
    
    func toAnyObject() -> Any {
        return [
            "fullName": fullName,
            "email": email,
            "address": address,
            "password": password,
            "creditCard": [
               "name": self.creditCard.name,
               "number": self.creditCard.number,
               "since": self.creditCard.since,
               "cvv": self.creditCard.cvv
            ]
        ]
    }
}

class CreditCard {
    var name:String!
    var number:String!
    var since:String!
    var cvv:String!
    
    init(name: String, number: String, since: String, cvv: String ) {
        self.name = name
        self.number = number
        self.since = since
        self.cvv = cvv
    }
}
