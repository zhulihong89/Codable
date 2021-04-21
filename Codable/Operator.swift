//
//  Operator.swift
//  Codable
//
//  Created by lihong on 2019/7/31.
//  Copyright © 2019 lihong. All rights reserved.
//

import UIKit

postfix operator ^

// MARK: - Value

public postfix func ^ (value: String?) -> String? {
    return value
}

public postfix func ^ (value: Int?) -> Int? {
    return value
}

public postfix func ^ (value: Double?) -> Double? {
    return value
}


// MARK: - Codable
public postfix func ^ (value: StringCodable?) -> String? {
    return value?.value
}

public postfix func ^ (value: IntCodable?) -> Int? {
    return value?.value
}

public postfix func ^ (value: DoubleCodable?) -> Double? {
    return value?.value
}

