//
//  Path.swift
//  Codable
//
//  Created by lihong on 2019/7/29.
//  Copyright © 2019 lihong. All rights reserved.
//

import UIKit

extension String {
    func stringByAppendPath(_ path: String) -> String {
        guard !path.isEmpty else {
            return self
        }
        
        let first = self.hasSuffix("/") ? String(self.dropLast()) : self
        let last = path.hasPrefix("/") ? String(path.dropFirst()) : path
        
        return "\(first)/\(last)"
    }
}

public typealias Path = String
public extension Path {
    static let document: Path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
    static let temp: Path = NSTemporaryDirectory()
    
    static func documentPath(_ path: String) -> String {
        return document.stringByAppendPath(path)
    }
    static func tempPath(_ path: String) -> String {
        return temp.stringByAppendPath("cache/\(path)")
    }
}

