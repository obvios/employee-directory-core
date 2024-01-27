//
//  Employee.swift
//  
//
//  Created by Eric Palma on 1/26/24.
//

import Foundation

public struct Employee: Identifiable {
    public typealias Identifier = String
    
    public let id: Identifier
    public let firstName: String
    public let lastName: String
    public let dateStarted: Date
    public let email: String
}
