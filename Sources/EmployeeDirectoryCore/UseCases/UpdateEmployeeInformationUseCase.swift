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
        try await repository.updateEmployeeInformation(employee: employee)
    }
}
