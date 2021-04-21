//
//  Codable+Extension.swift
//  Codable
//
//  Created by Lihong.zhu on 2018/7/11.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension Encodable {
    public func toJson() -> Data? {
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(self)
        
        return jsonData
    }
    
    public func toJsonString() -> String? {
        guard let data = toJson() else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}

extension Decodable {
    
    public static func fromJson(_ data: Data) -> Self? {
        let jsonDecoder = JSONDecoder()
        do {
            let modelObject = try jsonDecoder.decode(Self.self, from: data)
            
            return modelObject
        } catch let err as NSError {
            debugPrint(err)
            return nil
        }
    }
    
    public static func fromJsonString(_ string: String) -> Self? {
        guard let data = string.data(using: .utf8) else {
            return nil
        }
        
        return fromJson(data)
    }
    
    public static func fromJsonObject(_ object: Any) -> Self? {
        if self == String.self || self == Int.self || self == Double.self || self == Float.self {
            return object as? Self
        }
        
        guard JSONSerialization.isValidJSONObject(object)
            ,let data = try? JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.prettyPrinted) else {
                return nil
        }
        
        return fromJson(data)
    }
}
