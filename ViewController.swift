//
//  ViewController.swift
//  ShopifyMobileInternChallenge
//
//  Created by Vipul Srivastav on 2018-01-01.
//  Copyright © 2018 Vipul Srivastav. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    var productList = [Product]()
    
    var filteredProductList = [Product]()
    
    var isSearching = false
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("segue success")
        print(productList[0].description)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.placeholder = "Enter Title of Product"
        tableView.tableHeaderView = searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            
            return filteredProductList.count
            
        }
        
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
        
        let prod : Product
        
        if isSearching {
            
         prod = filteredProductList[indexPath.row]
            
            cell.textLabel?.text = filteredProductList[indexPath.row].title
            if !filteredProductList[indexPath.row].description.isEmpty
            {
                cell.detailTextLabel?.isEnabled = true
                cell.detailTextLabel?.text = filteredProductList[indexPath.row].description
            }
            do{
                let data: Data = try Data.init(contentsOf: filteredProductList[indexPath.row].imgSrc)
                cell.imageView?.image=UIImage(data:data)
            }
            catch {
                print(error)
                cell.imageView?.image = nil
            }
            return cell
        }
        else {
            
            prod = productList[indexPath.row]
            
            cell.textLabel?.text = productList[indexPath.row].title
            if !productList[indexPath.row].description.isEmpty
            {
                cell.detailTextLabel?.isEnabled = true
                cell.detailTextLabel?.text = productList[indexPath.row].description
            }
            do{
                let data: Data = try Data.init(contentsOf: productList[indexPath.row].imgSrc)
                cell.imageView?.image=UIImage(data:data)
            }
            catch {
                print(error)
                cell.imageView?.image = nil
            }
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailViewController = segue.destination as! DetailViewController
        if !(searchBar.text?.isEmpty)! && searchBar.text != "" {
            DetailViewController.product = filteredProductList[self.selectedIndex]
        }
        else {
        DetailViewController.product = productList[self.selectedIndex]
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            
            isSearching = true
    
            filteredProductList = productList.filter({ (product: Product) -> Bool in
                return product.title.range(of: searchBar.text!) != nil
            })
            tableView.reloadData()
        }
       
    }
}

