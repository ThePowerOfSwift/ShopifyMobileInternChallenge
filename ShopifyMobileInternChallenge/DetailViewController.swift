//
//  DetailViewController.swift
//  ShopifyMobileInternChallenge
//
//  Created by Vipul Srivastav on 2018-01-01.
//  Copyright © 2018 Vipul Srivastav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    @IBOutlet var productImg: UIImageView!
    //id
    @IBOutlet var productLabel: UILabel!
    
    @IBOutlet var productTitle: UILabel!
    
    @IBOutlet var productDesc: UILabel!
    
    @IBOutlet var productVendor: UILabel!
    
    @IBOutlet var productType: UILabel!

    @IBOutlet var productScope: UILabel!
    
    var product: Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            let data: Data = try Data.init(contentsOf: product!.imgSrc)
            productImg.image=UIImage(data:data)
        }
        catch {
            print(error)
        }
        
         let url = "https://shopicruit.myshopify.com/admin/products/\(product!.productId).json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //Detailed Information
                print("Product ID = \(self.product.productId)")
                print("Title = \(json["product"]["title"])")
                print("Detailed Description = \(json["product"]["body_html"])")
                print("Vendor = \(json["product"]["vendor"])")
                print("Product_Type = \(json["product"]["product_type"])")
                print("Published Scope = \(json["product"]["published_scope"])")
                //Detailed Information
                
                self.productLabel.text = self.product.productId
                self.productTitle.text = String(describing: json["product"]["title"])
                self.productDesc.text = String(describing: json["product"]["body_html"])
                self.productVendor.text = String(describing: json["product"]["vendor"])
                self.productType.text = String(describing: json["product"]["product_type"])
                self.productScope.text = String(describing: json["product"]["published_scope"])
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
