//
//  StringCodable.swift
//  Codable
//
//  Created by lihong on 2019/6/24.
//  Copyright © 2019 qy. All rights reserved.
//

import Foundation

public struct StringCodable: Codable, ReadWrite, CustomStringConvertible {
    public var value: String?
    
    public init(value: String?) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        if let decodedString = try? container?.decode(String.self) {
            value = decodedString
        } else if let decodedInt = try? container?.decode(Int.self) {
            value = "\(decodedInt)"
        } else if let decodedDouble = try? container?.decode(Double.self) {
            value = "\(decodedDouble)"
        } else {
            value = nil
        }
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
        return value ?? ""
    }
}
