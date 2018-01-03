//
//  InitViewController.swift
//  ShopifyMobileInternChallenge
//
//  Created by Vipul Srivastav on 2018-01-01.
//  Copyright © 2018 Vipul Srivastav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Product
{
    var title:String
    var description:String
    var imgSrc:URL
    var productId: String
    var detailedDescription: String
}

class InitViewController: UIViewController {
    let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    var i : Int? = nil
    var countProduct : Int = 0
    var productList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTable.isEnabled = false
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("Total No. of Products = \(json["products"].count)")
                self.countProduct = json["products"].count
                for i in 0...self.countProduct-1
                {
                    print("=================")
                    print(json["products"][i]["title"])
                    print(json["products"][i]["id"])
                    
                    self.productList.append(Product.init(title: String(describing: json["products"][i]["title"]), description: String(describing: json["products"][i]["body_html"]), imgSrc: URL.init(string: String(describing: json["products"][i]["images"][0]["src"]))!, productId:String(describing: json["products"][i]["id"]), detailedDescription: ""))
                    
                    print(json["products"][i]["body_html"])
                    print(json["products"][i]["images"][0]["src"])
                    print(self.productList[0])
                    self.showTable.isEnabled = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBOutlet var showTable: UIButton!
    
    @IBAction func gotoTable(_ sender: UIButton) {
        
        performSegue(withIdentifier: "productsView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let ViewController = segue.destination as! ViewController
        ViewController.productList = productList
    }
}
