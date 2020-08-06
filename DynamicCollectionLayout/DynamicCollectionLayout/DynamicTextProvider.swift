//
//  DynamicTextProvider.swift
//  DynamicCollectionLayout
//
//  Created by jeongjinho on 2020/07/28.
//  Copyright © 2020 jeongjinho. All rights reserved.
//

import Foundation

class DynamicTextProvider {
    
    class func loadDynamicTextList() -> [String] {

        if let path = Bundle.main.path(forResource: "DynamicText", ofType: ".json"), let  data = try? String(contentsOfFile: path).data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
               
                let list = json["List"] as? [String]
                return list ?? []
            }
            catch let erorr as NSError {
                print(erorr.localizedDescription)
            }
        }
         return []
    }
    
    class func loadMoreTextList() -> [String] {
        
        if let path = Bundle.main.path(forResource: "DynamicMoreText", ofType: ".json"), let data = try? String(contentsOfFile: path).data(using: .utf8) {
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let list = json["List"] as? [String]
                return list ?? []
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return []
    }
}
