import XCTest
@testable import salary_manager

class salary_managerTests: XCTestCase {
    
    var tvc: TransactionsViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tvc = storyboard.instantiateViewController(withIdentifier: "TransactionsViewController") as! TransactionsViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCcyConversion() {
        XCTAssertEqual(tvc.covertToCurrency(number: 200, ccy: "USD"), "5.59")
        XCTAssertEqual(tvc.covertToCurrency(number: 990, ccy: "USD"), "27.66")
        XCTAssertEqual(tvc.covertToCurrency(number: 4500, ccy: "JPY"), "14,808")
    }
    
}
