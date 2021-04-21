//
//  ContainArr.swift
//  Codable
//
//  Created by Lihong.zhu on 2018/11/14.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(of element: Element)  {
        guard let idx = firstIndex(of: element) else {
            return
        }
        remove(at: idx)
    }
}

struct ContainArr<Element: Codable & Equatable> {
    
    let key: String
    let dir: String?
    private var arr: [Element]
    
    init(_ k: String, dir d: String? = nil) {
        key = k
        dir = d
        arr = [Element].read(key, path: Path.document) ?? []
    }
    
    func object(at index: Int) -> Element? {
        guard 0 <= index && index < arr.count else {
            return nil
        }
        
        return arr[index]
    }
    
    mutating func append(_ newElement: Element) {
        arr.append(newElement)
        arr.write(self.key, path: Path.document)
    }
    
    mutating func remove(of element: Element) {
        arr.remove(of: element)
        arr.write(self.key, path: Path.document)
    }
    
    mutating func remove(at index: Int) {
        arr.remove(at: index)
        arr.write(self.key, path: Path.document)
    }

}
