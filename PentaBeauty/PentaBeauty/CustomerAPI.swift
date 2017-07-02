//
//  CustomerAPI.swift
//  PentaBeauty
//
//  Created by MacDD02 on 01/07/17.
//  Copyright © 2017 darlandev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CustomerAPI {
    
    init() {
    }
    
    func getImages(query: String, withCompletionHandler completionHandler: @escaping (_ resp: [Product]) -> Void) -> Void {
        print(query)
        let url = "https://www.googleapis.com/customsearch/v1?cx=013479246171923980404:ebdgbblqs9e&q=\(query)&key=AIzaSyDXE3RqJFYlwOSLlpJ8dH48SB5_TUZeTk4&searchType=image"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var products:[Product] = []
                
                for img in json["items"] {
                    let pd = Product(title: img.1["title"].string!, url: img.1["link"].string!)
                    products.append(pd)
                }
                
                completionHandler(products)
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
   /* func getImages() -> [String]{
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let image = json["items"][0]["link"].string
                
                let images:[String]!
                images.append(image!)
                
                print(images)
                
                return images
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }*/
}
