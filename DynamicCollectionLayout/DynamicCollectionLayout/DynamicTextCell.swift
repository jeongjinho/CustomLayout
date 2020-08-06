//
//  DynamicTextCell.swift
//  DynamicCollectionLayout
//
//  Created by jeongjinho on 2020/07/28.
//  Copyright © 2020 jeongjinho. All rights reserved.
//

import UIKit

class DynamicTextCell: UICollectionViewCell {
    
    
    let textLabel: UILabel = UILabel()
    
    var heightContraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel.numberOfLines = 0
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
      heightContraint = textLabel.heightAnchor.constraint(equalToConstant: 100)
        heightContraint.isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
       // heightContraint.constant = 0
    }
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! DynamicLayoutAttributes
        heightContraint.constant = attributes.textHeight 
    }
    
}
