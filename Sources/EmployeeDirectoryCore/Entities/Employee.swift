//
//  Employee.swift
//  
//
//  Created by Eric Palma on 1/26/24.
//

import Foundation

public struct Employee: Identifiable, Codable {
    public typealias Identifier = String
    
    public let id: Identifier
    public let firstName: String
    public let lastName: String
    public let dateStarted: Date
    public let email: String
    public let title: String
    
    public init(id: Identifier,
                firstName: String,
                lastName: String,
                dateStarted: Date,
                email: String,
                title: String) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.dateStarted = dateStarted
            self.email = email
            self.title = title
    }
}
