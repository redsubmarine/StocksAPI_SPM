import XCTest
@testable import StocksAPI

final class StocksAPITests: XCTestCase {
    var sut: StocksAPI!
    
    override func setUp() async throws {
        sut = StocksAPI()
    }
    
    override func tearDown() async throws {
        sut = nil
    }
    
    func testGetQuote() async throws {
        let quotes = try await sut.fetchQuotes(symbols: "AAPL,MSFT,GOOG,TSLA")
        XCTAssertGreaterThan(quotes.count, 0)
        XCTAssertEqual(quotes[0].currency, "USD")
    }
    
    func testGetQuoteError() async throws {
        do {
            _ = try await sut.fetchQuotes(symbols: "")
            XCTFail()
        } catch {
            if case let .httpStatusCodeFailed(statusCode, _) = (error as! APIError) {
                XCTAssertEqual(statusCode, 400)
            } else {
                XCTFail()
            }
        }
    }
    
    func testGetTickers() async throws {
        let quotes = try await sut.searchTickers(query: "tesla")
        XCTAssertGreaterThan(quotes.count, 0)
    }
    
    func testGetTickersError() async throws {
        do {
            _ = try await sut.searchTickers(query: "")
            XCTFail()
        } catch {
            if case let .httpStatusCodeFailed(statusCode, _) = (error as! APIError) {
                XCTAssertEqual(statusCode, 400)
            } else {
                XCTFail()
            }
        }
    }
    
    func testGetChart() async throws {
        let chart = try await sut.fetchChartData(symbol: "AAPL", range: .oneDay)
        XCTAssertNotNil(chart)
    }
    
    func testGetChartError() async throws {
        do {
            _ = try await sut.fetchChartData(symbol: "thereisnoticker", range: .oneDay)
            XCTFail()
        } catch {
            if case let .httpStatusCodeFailed(statusCode, _) = (error as! APIError) {
                XCTAssertEqual(statusCode, 404)
            } else {
                XCTFail()
            }
        }
    }

}
