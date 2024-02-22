//
//  File.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import Foundation

public class FetchEmployeeDetailsUseCase {
    private let repository: EmployeesRepository

    public init(repository: EmployeesRepository) {
        self.repository = repository
    }

    public func execute(employeeId: String) async throws -> Employee {
        return try await repository.fetchEmployeeDetails(id: employeeId)
    }
}
