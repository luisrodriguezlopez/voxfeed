//
//  PublicationsDataProviderTests.swift
//  voxfeedTests
//
//  Created by iMAC4 on 20/12/17.
//  Copyright © 2017 Luis Rodríguez. All rights reserved.
//

import XCTest
@testable import voxfeed
class PublicationsDataProviderTests: XCTestCase {
    let sut = PublicationDataProvider()
    var tableView: UITableView!
    var cell: MockItemCell!
     let prmomotedMessages = ["id":"1","date":"2016-09-01T06:00:00.000Z","socialNetwork":"facebook","user":["username":"GeekZone","profileImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/profile-image1.png"],"campaign":["name":"Daredevil","coverImage":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-cover1.jpg"],"brand":["name":"Netflix","logo":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/campaign-brand1.png"],"post":["text":"#DaredevilReturns con la nueva temporada en primavera, por si no saben que hacer el próximo fin. #NetflixLoTiene #MarvelSeries","image":"https://s3.amazonaws.com/voxfeed.assets/apps-development-test/post-image1.jpg","link":"https://www.facebook.com/VoxFeed/posts/753620444739473"],"stats":["clicks":25,"shares":17,"likes":54,"comments":4,"audience":1200],"earnings":120] as [String : Any]
    
    override func setUp() {
        super.setUp()
        self.tableView = MockPublicationView()
        self.tableView.dataSource = sut
    }
    
    func test_NumberOfRows_Section_() {
        XCTAssertEqual(self.tableView.numberOfRows(inSection: 0) , 0)
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: prmomotedMessages as NSDictionary)
        sut.model = [promotedMessage]
        self.tableView.reloadData()
        XCTAssertEqual(self.tableView.numberOfRows(inSection: 0) , 1)
    
    }
    
    func test_CellForRow_ReturnsItemCell() {

        let promotedMessage : PromotedMessage = PromotedMessage.init(data: prmomotedMessages as NSDictionary)
        sut.model = [promotedMessage]
        tableView.reloadData()
        tableView.dataSource  = sut
        tableView.register(MockItemCell.self,
                               forCellReuseIdentifier: "CardPublicationCell")
        cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell

        XCTAssertTrue(cell is CardPublicationCell)
    }
    
    func test_CellForRow_DequeuesCellFromTableView() {
        let mockTableView = MockPublicationView.mockTableView(withDataSource: sut)
        mockTableView.dataSource = sut
        mockTableView.register(MockItemCell.self,
                               forCellReuseIdentifier: "CardPublicationCell")
    
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: prmomotedMessages as NSDictionary)
        sut.model = [promotedMessage]
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func test_CellForRow_CallsConfigCell() {
        let mockTableView = MockPublicationView.mockTableView(withDataSource: sut)
        mockTableView.dataSource = sut
        let promotedMessage : PromotedMessage = PromotedMessage.init(data: prmomotedMessages as NSDictionary)
        sut.model = [promotedMessage]
        mockTableView.reloadData()

        cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
        cell.configCell(imagesDictionary: [], currentPublication: (sut.model?[0])!)
        XCTAssertEqual(cell.catchedItem, promotedMessage)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
}

extension PublicationsDataProviderTests {
    class MockPublicationView : UITableView {
        var cellGotDequeued = false
        
        
        override func dequeueReusableCell(withIdentifier identifier: String,for indexPath: IndexPath) -> UITableViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockPublicationView {
            let mockTableView = MockPublicationView()
            mockTableView.dataSource = dataSource
            mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "CardPublicationCell")
            return mockTableView
        }
    }
    
    
    class MockItemCell : CardPublicationCell {
        var configCellGotCalled = false
        var catchedItem : PromotedMessage?
        
        override func configCell(imagesDictionary: [NSDictionary]!, currentPublication: PromotedMessage) -> CardPublicationCell {
            catchedItem = currentPublication
            return self
        }
    }


}
