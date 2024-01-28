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

    public func execute(searchTerm: String? = nil) async throws -> [Employee] {
        let allEmployees = try await repository.fetchEmployees()
        
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            return allEmployees
        }

        return allEmployees.filter { employee in
            employee.firstName.lowercased().contains(searchTerm.lowercased()) ||
            employee.lastName.lowercased().contains(searchTerm.lowercased())
        }
    }
}
