//
//  DetailsViewController.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    static let identifier = "DetailsViewController"
    
    @IBOutlet var tableView: UITableView!
    
    var collection: Collection!
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let collectionID = collection.id {
            getCollects(collectionID: collectionID)
        }
    }
    
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 132
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    func config(collection: Collection) {
        self.collection = collection
    }
    
    private func getCollects(collectionID: Int) {
        Service.sharedService.getCollects(collectionID: collectionID) { (result) in
            if let collects = result.value {
                self.getProducts(collects: collects)
            }
        }
    }
    
    private func getProducts(collects: [Collect]) {
        Service.sharedService.getProducts(collects: collects) { (result) in
            if let products = result.value  {
                self.products = products
                self.tableView.reloadData()
            }
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        cell.config(product: products[indexPath.row], collection: collection)
        return cell
    }
}


