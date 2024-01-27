//
//  File.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import Foundation

class FetchEmployeeDetailsUseCase {
    private let repository: EmployeesRepository

    init(repository: EmployeesRepository) {
        self.repository = repository
    }

    func execute(employeeId: String) async throws -> Employee {
        return try await repository.fetchEmployeeDetails(id: employeeId)
    }
}
