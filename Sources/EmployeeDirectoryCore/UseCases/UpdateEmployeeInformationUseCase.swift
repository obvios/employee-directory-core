//
//  File.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import Foundation

public class UpdateEmployeeInformationUseCase {
    private let repository: EmployeesRepository

    init(repository: EmployeesRepository) {
        self.repository = repository
    }

    public func execute(employee: Employee) async throws {
        try validateEmail(for: employee)
        try await repository.updateEmployeeInformation(employee: employee)
    }
    
    private func validateEmail(for employee: Employee) throws {
        let expectedEmail = "\(employee.firstName).\(employee.lastName)@example.com"
        guard employee.email.lowercased() == expectedEmail.lowercased() else {
            throw ValidationError.invalidEmail
        }
    }
}

enum ValidationError: Error {
    case invalidEmail
}
