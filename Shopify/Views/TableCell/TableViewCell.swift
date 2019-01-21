//
//  TableViewCell.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    @IBOutlet var collectionLabel: UILabel!
    
    var collection: Collection!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(collection: Collection) {
        self.collection = collection
        collectionLabel.text = collection.title
    }
}
