//
//  TableViewController.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    static let identifier = "TableViewController"
    @IBOutlet var tableView: UITableView!
    var collections = [Collection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCollections()
    }
    
    private func config() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: TableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 85
        tableView.tableFooterView = UIView()
    }
    
    private func getCollections() {
        Service.sharedService.getCustomCollections { (result) in
            if let collections = result.value  {
                self.collections = collections
                self.tableView.reloadData()
            }
        }
    }
    
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Details", bundle: nil).instantiateViewController(withIdentifier: DetailsViewController.identifier) as! DetailsViewController
        vc.config(collection: collections[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.config(collection: collections[indexPath.row])
        return cell
    }
}
