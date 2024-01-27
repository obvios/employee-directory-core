//
//  FetchEmployeeListUseCaseTests.swift
//  
//
//  Created by Eric Palma on 1/27/24.
//

import XCTest
@testable import EmployeeDirectoryCore

final class FetchEmployeeListUseCaseTests: XCTestCase {

    func testFetchEmployeeListSuccess() async throws {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let expectedEmployees = [Employee(id: "1", firstName: "John", lastName: "Doe", dateStarted: Date(), email: "john.doe@example.com"),
                                 Employee(id: "2", firstName: "Joe", lastName: "Common", dateStarted: Date(), email: "joe.common@example.com")]
        mockRepository.employees = expectedEmployees
        let useCase = FetchEmployeeListUseCase(repository: mockRepository)

        // Act
        let result = try await useCase.execute()

        // Assert
        XCTAssertEqual(result.count, expectedEmployees.count)
        XCTAssertEqual(result[0].id, expectedEmployees[0].id)
        XCTAssertEqual(result[1].firstName, expectedEmployees[1].firstName)
    }

    func testFetchEmployeeListFailure() async {
        // Arrange
        let mockRepository = MockEmployeesRepository()
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        mockRepository.error = expectedError
        let useCase = FetchEmployeeListUseCase(repository: mockRepository)

        // Act and Assert
        do {
            _ = try await useCase.execute()
            XCTFail("Expected to throw an error, but it did not")
        } catch {
            // Ensure the error is the expected error
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
}

fileprivate class MockEmployeesRepository: EmployeesRepository {
    var employees: [Employee]?
    var error: Error?

    func fetchEmployees() async throws -> [Employee] {
        if let error = error {
            throw error
        }
        if let employees = employees {
            return employees
        }
        fatalError("MockEmployeesRepository not properly set up")
    }
    
    func fetchEmployeeDetails(id: String) async throws -> EmployeeDirectoryCore.Employee {
        fatalError("this method should not be called from FetchEmployeeListUseCase")
    }
    
    func updateEmployeeInformation(employee: EmployeeDirectoryCore.Employee) async throws {
        fatalError("this method should not be called from FetchEmployeeListUseCase")
    }
}

