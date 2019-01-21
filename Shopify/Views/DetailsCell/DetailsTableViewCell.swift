//
//  DetailsTableViewCell.swift
//  Shopify
//
//  Created by Paco Lee on 2019-01-20.
//  Copyright © 2019 Paco Lee. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var inventoryLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    
    static let identifier = "DetailsTableViewCell"
    var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(product: Product, collection: Collection) {
        self.product = product
        nameLabel.text = product.title
        titleLabel.text = collection.title
        
        if let variants = product.variants {
            var total = 0
            for variant in variants {
                total += variant.inventoryQuantity ?? 0
            }
            
            inventoryLabel.text = "\(total)"
        }
        
        if let image = product.image, let imageURL = image.src, let url = URL(string: imageURL)  {
            productImageView.downloaded(from: url)
        }
    }
}
