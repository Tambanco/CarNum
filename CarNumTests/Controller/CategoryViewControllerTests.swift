//
//  CategoryViewControllerTests.swift
//  CarNumTests
//
//  Created by tambanco 🥳 on 23.05.2021.
//  Copyright © 2021 Tambanco. All rights reserved.
//

import XCTest
@testable import CarNum

class CategoryViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewNotNilWhenViewIsLoaded() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: CategoryViewController.self))
        let sut = vc as! CategoryViewController
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }
 

}
