//
//  AppCoreTests.swift
//  
//
//  Created by Jay on 3/17/23.
//

import XCTest
import ComposableArchitecture
import AppCore
import NewProjectCore
import WIPKit
import API

@MainActor
final class AppCoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOnApperSuccess() async {
        let store = TestStore(
            initialState: AppCore.State(),
            reducer: AppCore()
        )

        await store.send(.onAppear)
        await store.receive(
            .getProjectsResponse(
                .success([
                    Project(
                        id: UUID(uuidString: "00000000-0000-0000-0000-000000000000"),
                        title: "Test Project"
                    )
                ])
            )
        ) {
            $0.projects = [
                Project(
                    id: UUID(uuidString: "00000000-0000-0000-0000-000000000000"),
                    title: "Test Project"
                )
            ]
        }
    }

    func testOnAppearError() async {
        let store = TestStore(
            initialState: AppCore.State(),
            reducer: AppCore()
        )
        store.dependencies.apiClient.fetchAllProjects = { throw APIError() }

        await store.send(.onAppear)

        await store.receive(.getProjectsResponse(.failure(APIError()))) {
            $0.apiError = APIError()
        }
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

    func testNewProjectCancelTapped() async {
        let store = TestStore(
            initialState: AppCore.State(),
            reducer: AppCore()
        )
        await store.send(.addProjectButtonTapped) {
            $0.showAddProjectForm = true
        }
        await store.send(.newProject(.cancelButtonTapped))
        await store.receive(.newProject(.delegate(.cancelButtonTapped))) {
            $0.showAddProjectForm = false
        }
    }

    func testNewProjectSuccessfulResponse() async {
        let store = TestStore(
            initialState: AppCore.State(),
            reducer: AppCore()
        )
        await store.send(.addProjectButtonTapped) {
            $0.showAddProjectForm = true
        }
        await store.send(.newProject(.addProjectButtonTapped))
        await store.receive(
            .newProject(
                .createProjectResponse(
                    .success(
                        Project(
                            id: UUID(uuidString: "00000000-0000-0000-0000-000000000000"),
                            title: "Test Project"
                        )
                    )
                )
            )
        )
        await store.receive(.newProject(.delegate(.successfulResponse))) {
            $0.showAddProjectForm = false
        }
    }

}
