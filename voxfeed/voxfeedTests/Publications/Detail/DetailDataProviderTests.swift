//
//  DetailDataProviderTests.swift
//  voxfeedTests
//
//  Created by iMAC4 on 21/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import XCTest
@testable import voxfeed
class DetailDataProviderTests: XCTestCase {
    let sut = DetailDataProvider()
    var tableView: UITableView!
    let promotedMessages = ["id":"1","date":"2016-09-01T06:00:00.000Z","socialNetwork":"facebook","user":["username":"GeekZone","profileImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/profile-image1.png"],"campaign":["name":"Daredevil","coverImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-cover1.jpg"],"brand":["name":"Netflix","logo":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-brand1.png"],"post":["text":"#DaredevilReturns con la nueva temporada en primavera, por si no saben que hacer el próximo fin. #NetflixLoTiene #MarvelSeries","image":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/post-image1.jpg","link":"https://www.facebook.com/VoxFeed/posts/753620444739473"],"stats":["clicks":25,"shares":17,"likes":54,"comments":4,"audience":1200],"earnings":120] as [String : Any]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        self.tableView = MockDetailView()
        self.tableView.dataSource = sut
    }

    func test_NumberOfRows_Section_() {
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: promotedMessages as NSDictionary)
        sut.promotedMessage = promotedMessage
        XCTAssertEqual(self.tableView.numberOfRows(inSection: 0) , 1)
        XCTAssertEqual(self.tableView.numberOfRows(inSection: 1) , 5)
    }

    func test_CellForRow_ReturnsHeaderCell() {
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: promotedMessages as NSDictionary)
        sut.promotedMessage = promotedMessage
        tableView.dataSource  = sut
        tableView.reloadData()
        tableView.register(MockHeaderCell.self,
                           forCellReuseIdentifier: "headerCell")
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is HeaderImageDetail)
    }
    
    func test_CellForRow_ReturnsStatsViewCell() {
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: promotedMessages as NSDictionary)
        sut.promotedMessage = promotedMessage
        tableView.dataSource  = sut
        tableView.reloadData()

        tableView.register(MockStatCell.self,
                           forCellReuseIdentifier: "statsCell")
        let cell1 = tableView.cellForRow(at: IndexPath(row: 0, section: 1))
//        XCTAssertEqual(self.tableView.numberOfRows(inSection: 0) , 1)
//        XCTAssertEqual(self.tableView.numberOfRows(inSection: 1) , 5)
        XCTAssertNotNil(cell1)
//        XCTAssertTrue(cell1 is StatsViewCell)

    }

//    func test_CellForRow_DequeuesCellFromTableView() {
//        let mockDetailView = MockDetailView.mockDetailView(withDataSource: sut)
//        mockDetailView.dataSource = sut
//        mockDetailView.register(MockStatCell.self,
//                               forCellReuseIdentifier: "statsCell")
//
//        let promotedMessage = PromotedMessage.init(data: promotedMessages as NSDictionary)
//        sut.promotedMessage  = promotedMessage
//        mockDetailView.reloadData()
//
//        let cell = mockDetailView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockStatCell
//
//
//        XCTAssertTrue(cell.configCellGotCalled)
//    }
////
//    func test_CellForRow_CallsConfigCell() {
//        let mockTableView = MockPublicationView.mockTableView(withDataSource: sut)
//        mockTableView.dataSource = sut
//        let promotedMessage : PromotedMessage = PromotedMessage.init(data: prmomotedMessages as NSDictionary)
//        sut.model = [promotedMessage]
//        mockTableView.reloadData()
//
//        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
//
//        XCTAssertEqual(cell.catchedItem, promotedMessage)
//    }
}


extension DetailDataProviderTests {
        class MockDetailView : UITableView {
            var cellGotDequeued = false
            
            
            override func dequeueReusableCell(withIdentifier identifier: String,for indexPath: IndexPath) -> UITableViewCell {
                cellGotDequeued = true
                
                return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            }
            
            class func mockDetailView(withDataSource dataSource: UITableViewDataSource) -> MockDetailView {
                let mockDetailView = MockDetailView()
                mockDetailView.dataSource = dataSource
                mockDetailView.register(MockHeaderCell.self, forCellReuseIdentifier: "headerCell")
                mockDetailView.register(MockStatCell.self, forCellReuseIdentifier: "statsCell")

                return mockDetailView
            }
        }
    
    
    class MockHeaderCell : HeaderImageDetail {
        var configCellGotCalled = false
        var catchedItem : PromotedMessage?
        
       override func configCell(promotedMessage : PromotedMessage) {
            catchedItem = promotedMessage
        }
    }
    
    class MockStatCell : StatsViewCell {
        var configCellGotCalled = false
        var catchedItem : Stats?
        
        override func configCell(indexPath : IndexPath,cell : StatsViewCell, stats : Stats) -> StatsViewCell {
        catchedItem = stats
        return self
        }
        
    }

  
}




