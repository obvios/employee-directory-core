//
//  UpdateEmployeeInformationUseCase.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import XCTest
@testable import EmployeeDirectoryCore

final class UpdateEmployeeInformationUseCaseTests: XCTestCase {

    func testUpdateEmployeeInformationSuccess() async throws {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let employeeToUpdate = Employee(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            dateStarted: Date(),
            email: "john.doe@example.com",
            title: "iOS Developer"
        )
        let useCase = UpdateEmployeeInformationUseCase(repository: mockRepository)

        // Act
        try await useCase.execute(employee: employeeToUpdate)

        // Assert
        XCTAssertTrue(mockRepository.updateEmployeeCalled)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.id, employeeToUpdate.id)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.firstName, employeeToUpdate.firstName)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.lastName, employeeToUpdate.lastName)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.dateStarted, employeeToUpdate.dateStarted)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.email, employeeToUpdate.email)
    }

    func testUpdateEmployeeInformationFailure() async {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.error = expectedError
        let employeeToUpdate = Employee(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            dateStarted: Date(),
            email: "john.doe@example.com",
            title: "iOS Developer"
        )
        let useCase = UpdateEmployeeInformationUseCase(repository: mockRepository)

        // Act and Assert
        do {
            try await useCase.execute(employee: employeeToUpdate)
            XCTFail("Expected to throw an error, but it did not")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func testUpdateEmployeeInformationWithInvalidEmail() async {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let employeeWithInvalidEmail = Employee(
            id: "1",
            firstName: "John",
            lastName: "Doe",
            dateStarted: Date(),
            email: "invalid.email@example.com",
            title: "iOS Developer"
        )
        let useCase = UpdateEmployeeInformationUseCase(repository: mockRepository)

        // Act and Assert
        do {
            try await useCase.execute(employee: employeeWithInvalidEmail)
            XCTFail("Expected to throw ValidationError.invalidEmail, but it did not")
        } catch ValidationError.invalidEmail {
            // Test passes, expected error was thrown
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }

    func testUpdateEmployeeInformationWithValidEmail() async throws {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let employeeWithValidEmail = Employee(
            id: "2",
            firstName: "Jane",
            lastName: "Smith",
            dateStarted: Date(),
            email: "jane.smith@example.com",
            title: "Project Manager"
        )
        let useCase = UpdateEmployeeInformationUseCase(repository: mockRepository)

        // Act
        try await useCase.execute(employee: employeeWithValidEmail)

        // Assert
        XCTAssertTrue(mockRepository.updateEmployeeCalled)
        XCTAssertEqual(mockRepository.lastUpdatedEmployee?.email, employeeWithValidEmail.email)
    }
}

fileprivate class MockEmployeesRepository: EmployeesRepository {
    
    var employees: [Employee]?
    var error: Error?
    var updateEmployeeCalled = false
    var lastUpdatedEmployee: Employee?

    func fetchEmployees() async throws -> [Employee] {
        fatalError("this method should not be called from UpdateEmployeeInformationUseCase")
    }
    
    func fetchEmployeeDetails(id: String) async throws -> EmployeeDirectoryCore.Employee {
        fatalError("this method should not be called from UpdateEmployeeInformationUseCase")
    }

    func updateEmployeeInformation(employee: Employee) async throws {
        if let error = error {
            throw error
        }
        updateEmployeeCalled = true
        lastUpdatedEmployee = employee
    }
}
