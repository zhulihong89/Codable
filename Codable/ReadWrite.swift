//
//  LocalFile.swift
//  Codable
//
//  Created by Lihong.zhu on 2018/7/11.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit


public protocol ReadWrite {
}

public extension ReadWrite where Self: Codable {
    private static func defultName() -> String {
        let name = "\(type(of: self))"
        return name
    }
    
    func write(_ key: String? = nil, path: Path = Path.document, dir: String? = nil) {
        let key = key ?? type(of: self).defultName()
        
        var dataValue: Data?
        if self is String {
            dataValue = (self as? String)?.data(using: String.Encoding.utf8)
        } else {
            dataValue = self.toJson()
        }
        if dataValue == nil {
            dataValue = [self].toJson()
        }
        
        guard let data = dataValue else {
            return
        }
        var fileUrl = Self.cachePath(path, dir: dir)
        let fileManager = FileManager.default
        try? fileManager.createDirectory(at: fileUrl, withIntermediateDirectories: true, attributes: nil)
        
        fileUrl.appendPathComponent(key)
        DispatchQueue.global().async {
            try? data.write(to: fileUrl)
        }
    }
    
    static func read(_ key: String? = nil, path: Path = Path.document, dir: String? = nil) -> Self? {
        let key = key ?? self.defultName()
        var fileUrl = Self.cachePath(path, dir: dir)
        fileUrl.appendPathComponent(key)
        guard let data = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        if self is String.Type {
            return String(data: data, encoding: String.Encoding.utf8) as? Self
        }
        
        if let value = Self.fromJson(data) {
            return value
        }
        
        return ([Self].fromJson(data))?.first
    }
    
    static func delete(_ key: String, path: Path = Path.document, dir: String? = nil) {
        var fileUrl = Self.cachePath(path, dir: dir)
        fileUrl.appendPathComponent(key)

        let fileManager = FileManager.default
        _ = try? fileManager.removeItem(at: fileUrl)
    }
    
    private static func cachePath(_ path: Path, dir: String?) -> URL {
        var fileUrl = URL(fileURLWithPath: path)
        fileUrl.appendPathComponent("cache")
        if let dir = dir, dir.isEmpty == false {
            fileUrl.appendPathComponent(dir)
        }
        
        return fileUrl
    }
}

extension Array: ReadWrite {
}
extension Dictionary: ReadWrite {
}
extension String: ReadWrite {
}
