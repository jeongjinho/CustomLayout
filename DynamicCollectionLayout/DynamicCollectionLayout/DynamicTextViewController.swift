//
//  DynamicTextViewController.swift
//  DynamicCollectionLayout
//
//  Created by jeongjinho on 2020/07/28.
//  Copyright © 2020 jeongjinho. All rights reserved.
//

import UIKit

class DynamicTextViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: DynamicTextLayout())
    var dynamicTextList = DynamicTextProvider.loadDynamicTextList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        
        let layout = collectionView.collectionViewLayout as? DynamicTextLayout
        layout?.delegate = self
        layout?.padding = 30
        //  layout.
    }
    
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .white
    }
    
    func registerCell() {
        collectionView.register(DynamicTextCell.self, forCellWithReuseIdentifier: "DynamicTextCell")
    }
    
    
}


extension DynamicTextViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dynamicTextList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DynamicTextCell", for: indexPath) as! DynamicTextCell
        
        cell.textLabel.text = dynamicTextList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == dynamicTextList.count - 1 {
            let moreList = DynamicTextProvider.loadMoreTextList()
            self.dynamicTextList.append(contentsOf: moreList)
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }   
}


extension DynamicTextViewController: DynamicTextLayoutProtocol {
    func collectionView(collectionView: UICollectionView, heightForItemIndexPath: IndexPath, withWidth: CGFloat) -> CGFloat {
        let text = dynamicTextList[heightForItemIndexPath.item]
        return heghtForText(text, width: withWidth)
    }
    
    func heghtForText(_ text: String, width: CGFloat) -> CGFloat {
        
        let font = UIFont.systemFont(ofSize: 17)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
        
    }
    
}
