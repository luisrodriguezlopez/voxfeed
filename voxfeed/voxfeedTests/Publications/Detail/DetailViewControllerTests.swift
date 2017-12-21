//
//  DetailViewControllerTests.swift
//  voxfeedTests
//
//  Created by iMAC4 on 21/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import XCTest
@testable import voxfeed

class DetailViewControllerTests: XCTestCase {
    
    var sut : DetailViewController!
     let promotedMessages = ["id":"1","date":"2016-09-01T06:00:00.000Z","socialNetwork":"facebook","user":["username":"GeekZone","profileImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/profile-image1.png"],"campaign":["name":"Daredevil","coverImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-cover1.jpg"],"brand":["name":"Netflix","logo":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-brand1.png"],"post":["text":"#DaredevilReturns con la nueva temporada en primavera, por si no saben que hacer el próximo fin. #NetflixLoTiene #MarvelSeries","image":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/post-image1.jpg","link":"https://www.facebook.com/VoxFeed/posts/753620444739473"],"stats":["clicks":25,"shares":17,"likes":54,"comments":4,"audience":1200],"earnings":120] as [String : Any]
    override func setUp() {
        super.setUp()
  
        let storyboard = UIStoryboard(name: "Publications",
                                      bundle: nil)
        let viewController =
            storyboard.instantiateViewController(
                withIdentifier: "detailVC") as! UIViewController
        sut = viewController as! DetailViewController
        sut.promotedMessage = PromotedMessage.init(data: promotedMessages as! NSDictionary)
        sut.loadViewIfNeeded()
    }
    
    
    func test_LoadingView_SetsTableViewDelegate() {
        XCTAssertTrue(sut.tableView.delegate is DetailDataProvider)
    }
    
    func test_LoadingView_DataSourceEqualDelegate() {
        XCTAssertEqual(sut.tableView.dataSource as? DetailDataProvider,
                       sut.tableView.delegate as? DetailDataProvider)
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
}
