//
//  File.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import Foundation

public class FetchEmployeeListUseCase {
    private let repository: EmployeesRepository

    public init(repository: EmployeesRepository) {
        self.repository = repository
    }

    public func execute() async throws -> [Employee] {
        return try await repository.fetchEmployees()
    }
}

