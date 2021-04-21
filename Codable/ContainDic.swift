//
//  ContainDic.swift
//  Codable
//
//  Created by Lihong.zhu on 2018/11/14.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import Foundation

struct ContainDic<Key:Hashable & Codable,Value: Codable> {
    typealias Element = Dictionary<Key,Value>
    
    let key: String
    let dir: String?
    private var dic: Element
    
    // k: 存的文件名  dir：文件目录下
    init(_ k: String, dir d: String? = nil) {
        key = k
        dir = d
        dic = Element.read(key, path: Path.document, dir: dir) ?? [:]
    }
    
    func object(for key: Key) -> Value? {
        return dic[key]
    }
    
    mutating func set(object: Value, for key:Key) {
        dic[key] = object
        dic.write(self.key, path: Path.document, dir: dir)
    }
    
    func write() {
        dic.write(self.key, path: Path.document, dir: dir)
    }
}
