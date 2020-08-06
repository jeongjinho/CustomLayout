//
//  DynamicTextLayout.swift
//  DynamicCollectionLayout
//
//  Created by jeongjinho on 2020/07/28.
//  Copyright © 2020 jeongjinho. All rights reserved.
//

import UIKit

protocol DynamicTextLayoutProtocol {
    func collectionView(collectionView: UICollectionView, heightForItemIndexPath: IndexPath, withWidth: CGFloat) -> CGFloat
}

typealias ColumnYxis = (index: Int,colY: CGFloat)

class DynamicTextLayout: UICollectionViewLayout {
    var delegate: DynamicTextLayoutProtocol!
    var lastY: CGFloat = 0
    private var cache = [UICollectionViewLayoutAttributes]()
    private var width: CGFloat {
          get {
              let insets = collectionView!.contentInset
              return collectionView!.bounds.width - (insets.left + insets.right)
          }
      }
    
    override var collectionViewContentSize: CGSize  {
           return CGSize(width: width, height: lastY)
       }
       
       override class var layoutAttributesClass: AnyClass {
           return DynamicLayoutAttributes.self
       }
    
    override func prepare() {
       print("prepare()")
        cache.removeAll()
        guard let collectionView = collectionView else {
            return
        }
        lastY = 0
        //if cache.isEmpty {
            
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let textHeight = delegate.collectionView(collectionView: collectionView, heightForItemIndexPath: indexPath, withWidth: width)
            let originX: CGFloat = 0
            let originY : CGFloat = lastY
            //
            lastY += textHeight
            
            let frame = CGRect(x: originX, y: originY, width: width, height: textHeight)
            
            let attributes = DynamicLayoutAttributes(forCellWith: indexPath)
            attributes.textHeight = textHeight
            attributes.frame = frame
            cache.append(attributes)
            
        }
        //}
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("layoutAttributesForElements(in rect: CGRect)")
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if  rect.intersects(attributes.frame) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        print("layoutAttributesForItem(at indexPath: IndexPath)")
//        return cache[indexPath.item]
//    }
 
}


class DynamicLayoutAttributes: UICollectionViewLayoutAttributes {
    var textHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! DynamicLayoutAttributes
        copy.textHeight = textHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let atrributes = object as? DynamicLayoutAttributes {
            if atrributes.textHeight == textHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
