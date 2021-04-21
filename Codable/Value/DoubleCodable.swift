//
//  DoubleCodeable.swift
//  Codable
//
//  Created by lihong on 2019/6/24.
//  Copyright © 2019 qy. All rights reserved.
//

import Foundation

public struct DoubleCodable: Codable, ReadWrite, CustomStringConvertible {
    public var value: Double?
    
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer()
        if let decodedDouble = try? container?.decode(Double.self) {
            value = decodedDouble
        } else if let decodedString = try? container?.decode(String.self) {
            guard let decodedDouble = Double(decodedString) else {
                value = nil
                return
            }
            value = decodedDouble
        } else if let decodedInt = try? container?.decode(Int.self) {
            value = Double(decodedInt)
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
        if let value = value {
            return "\(value)"
        }
        return ""
    }
}
