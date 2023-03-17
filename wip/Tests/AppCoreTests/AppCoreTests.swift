//
//  AppCoreTests.swift
//  
//
//  Created by Jay on 3/17/23.
//

import XCTest
import ComposableArchitecture
import AppCore

@MainActor
final class AppCoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddProjectButtonTapped() async {
        let store = TestStore(
            initialState: AppCore.State(),
            reducer: AppCore()
        )

        await store.send(.addProjectButtonTapped) {
            $0.showAddProjectForm = true
        }
    }

}
