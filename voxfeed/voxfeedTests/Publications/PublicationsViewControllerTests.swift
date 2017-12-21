//
//  PublicationsTests.swift
//  voxfeedTests
//
//  Created by iMAC4 on 20/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import XCTest
@testable import voxfeed
class PublicationsTests: XCTestCase {
    var sut : PublicationsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Publications",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "publicationsViewController") as! UITableViewController
        sut = viewController as! PublicationsViewController
        sut.loadViewIfNeeded()

        
    }
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is PublicationDataProvider)
    }
    
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as? PublicationDataProvider,
                       sut.tableView.delegate as? PublicationDataProvider)
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
