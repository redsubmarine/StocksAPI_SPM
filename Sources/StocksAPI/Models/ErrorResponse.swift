//
//  ErrorResponse.swift
//  
//
//  Created by 레드 on 2023/02/22.
//

import Foundation

public struct ErrorResponse: Codable {
    public let code: String
    public let description: String
    
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}
