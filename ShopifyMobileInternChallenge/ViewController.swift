//
//  ViewController.swift
//  ShopifyMobileInternChallenge
//
//  Created by Vipul Srivastav on 2017-12-14.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
//struct productObj
//{
//    var title:String
//    var description:String
//    var imgSrc:URL
//    var productId: String
//}

class ViewController: UIViewController {
    let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    var i : Int? = nil
    var countProduct : Int = 0
    var productList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        Alamofire.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print("Total No. of Products = \(json["products"].count)")
//                self.countProduct = json["products"].count
//                for i in 0...self.countProduct-1
//                for i in 0...self.countProduct-50
//                {
//                    print("=================")
//                    print(json["products"][i]["title"])
                    
//                    self.titleList.append(String(describing: json["products"][i]["title"]))
//                    self.descList.append(String(describing: json["products"][i]["body_html"]))
//                    self.imgSrcList.append(URL.init(string: String(describing: json["products"][i]["images"][0]["src"]))!)
//
//                    print(json["products"][i]["id"])
//
//                    let urlProduct = "https://shopicruit.myshopify.com/admin/products/\(String(describing: json["products"][i]["id"])).json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
//                    Alamofire.request(urlProduct, method: .get).validate().responseJSON { response in
//                        switch response.result {
//                        case .success(let value):
//                            let json = JSON(value)
//                            print("Detailed Description: \(json["body_html"])")
//                        case .failure(let error):
//                            print(error)
//                        }
//                    }
                
//                    self.productList.append(productObj.init(title: String(describing: json["products"][i]["title"]), description: String(describing: json["products"][i]["body_html"]), imgSrc: URL.init(string: String(describing: json["products"][i]["images"][0]["src"]))!, productId:String(describing: json["products"][i]["id"]) ))

//                    print(json["products"][i]["body_html"])
//                    print(json["products"][i]["images"][0]["src"])
//                    print(self.productList[0])
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        print("segue success")
         print(self.productList[0])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier:"ProductCell")
         cell.textLabel?.text = productList[indexPath.row].description

        return cell
    }

}

