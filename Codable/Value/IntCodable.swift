//
//  IntCodable.swift
//  Codable
//
//  Created by lihong on 2019/6/24.
//  Copyright © 2019 qy. All rights reserved.
//

import Foundation

public struct IntCodable: Codable, ReadWrite, CustomStringConvertible {
    public var value: Int?
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        if let decodedInt = try? container?.decode(Int.self) {
            value = decodedInt
        } else if let decodedString = try? container?.decode(String.self) {
            guard let decodedInt = Int(decodedString) else {
                value = nil
                return
            }
            
            value = decodedInt
        } else if let decodedDouble = try? container?.decode(Double.self) {
            value = Int(decodedDouble)
        }else {
            value = nil
        }
    }
    
    public init(_ value: Int) {
        self.value = value
    }
    
    public func encode(to encoder: Encoder) throws {
        do {
            var container = encoder.singleValueContainer()
            try container.encode(value)
        } catch let error as NSError {
            throw error
        }
    }
    
    public var description: String {
        if let value = value {
            return "\(value)"
        }
        return ""
    }
}

