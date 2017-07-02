//
//  HomeDealerTableViewController.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class HomeDealerTableViewController : UIViewController {
    override func viewDidLoad() {
        let logo = UIImage(named: "Fontenew.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
    }
}
