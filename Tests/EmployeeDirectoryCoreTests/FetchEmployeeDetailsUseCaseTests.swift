//
//  FetchEmployeeDetailsUseCaseTests.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import XCTest
@testable import EmployeeDirectoryCore

final class FetchEmployeeDetailsUseCaseTests: XCTestCase {

    func testFetchEmployeeDetailsSuccess() async throws {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let expectedEmployee = Employee(id: "1", firstName: "John", lastName: "Doe", dateStarted: Date(), email: "john.doe@example.com")
        mockRepository.employeeDetails = expectedEmployee
        let useCase = FetchEmployeeDetailsUseCase(repository: mockRepository)

        // Act
        let result = try await useCase.execute(employeeId: "123")

        // Assert
        XCTAssertEqual(result.id, expectedEmployee.id)
        XCTAssertEqual(result.firstName, expectedEmployee.firstName)
        XCTAssertEqual(result.lastName, expectedEmployee.lastName)
        XCTAssertEqual(result.dateStarted, expectedEmployee.dateStarted)
        XCTAssertEqual(result.email, expectedEmployee.email)
    }

    func testFetchEmployeeDetailsFailure() async {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.error = expectedError
        let useCase = FetchEmployeeDetailsUseCase(repository: mockRepository)

        // Act and Assert
        do {
            _ = try await useCase.execute(employeeId: "123")
            XCTFail("Expected to throw an error, but it did not")
        } catch {
            // Ensure the error is the expected error
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

fileprivate class MockEmployeesRepository: EmployeesRepository {
    var employeeDetails: Employee?
    var error: Error?

    func fetchEmployeeDetails(id: String) async throws -> Employee {
        if let error = error {
            throw error
        }
        if let employeeDetails = employeeDetails {
            return employeeDetails
        }
        fatalError("MockEmployeesRepository not properly set up")
    }
    
    func fetchEmployees() async throws -> [EmployeeDirectoryCore.Employee] {
        fatalError("should not be called by FetchEmployeeDetailsUseCase")
    }
    
    func updateEmployeeInformation(employee: EmployeeDirectoryCore.Employee) async throws {
        fatalError("should not be called by FetchEmployeeDetailsUseCase")
    }
}
