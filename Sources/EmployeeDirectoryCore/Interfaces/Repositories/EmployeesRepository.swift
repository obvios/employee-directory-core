//
//  File.swift
//  
//
//  Created by Eric Palma on 1/26/24.
//

import Foundation

public protocol EmployeesRepository {
    func fetchEmployees() async throws -> [Employee]
}
