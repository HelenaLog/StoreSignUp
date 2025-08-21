import XCTest
@testable import StoreSignUp

final class APIServiceTests: XCTestCase {
    
    func testFetchProductSuccess() async throws {
        let mockNetworkClient = MockNetworkClient()
        let product = Item(
            id: 25,
            title: "Product Name",
            price: 39.99,
            description: "Product description",
            image: "https://fakestoreapi.com/img/71HblAHs5xL._AC_UY879_-2t.png"
        )
        
        let products = [product]
        let responseData = try JSONEncoder().encode(products)
        mockNetworkClient.responseData = responseData
        let apiService = StoreAPIService(networkClient: mockNetworkClient)
        
        let fetchedProducts = try await apiService.fetchProducts()
        
        XCTAssertEqual(fetchedProducts.count, 1)
        XCTAssertEqual(fetchedProducts.first?.id, product.id)
        XCTAssertEqual(fetchedProducts.first?.title, product.title)
        XCTAssertEqual(fetchedProducts.first?.price, product.price)
        XCTAssertEqual(fetchedProducts.first?.description, product.description)
        XCTAssertEqual(fetchedProducts.first?.image, product.image)
    }
    
    func testFetchProductError() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        mockNetworkClient.responseError = APIError.network(NSError(domain: "Network error", code: -1009))
        
        let apiService = StoreAPIService(networkClient: mockNetworkClient)
        
        do {
            _ = try await apiService.fetchProducts()
            XCTFail("Expected error, but got success")
        } catch let error as APIError {
            switch error {
            case .network(let nsError as NSError):
                XCTAssertEqual(nsError.code, -1009)
            default:
                XCTFail("Expected error, but got: \(error)")
            }
        } catch {
            XCTFail("Expected error, but got: \(error)")
        }
    }
    
    func testInvalidStatusCode() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        mockNetworkClient.responseData = Data()
        mockNetworkClient.responseStatusCode = 404
        let apiService = StoreAPIService(networkClient: mockNetworkClient)
        
        do {
            _ = try await apiService.fetchProducts()
            XCTFail("Expected error, but got success")
        } catch let error as APIError {
            switch error {
            case .invalidResponse(let statusCode):
                XCTAssertEqual(statusCode, 404)
            default:
                XCTFail("Expected invalidResponse error, but got: \(error)")
            }
        } catch {
            XCTFail("Expected APIError, but got: \(error)")
        }
    }
    
    func testDecodingError() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        mockNetworkClient.responseData = Data("Invalid JSON".utf8)
        let apiService = StoreAPIService(networkClient: mockNetworkClient)
        
        do {
            _ = try await apiService.fetchProducts()
            XCTFail("Expected error, but got success")
        } catch let error as APIError {
            switch error {
            case .decoding:
                XCTAssertTrue(true)
            default:
                XCTFail("Expected decoding error, but got: \(error)")
            }
        } catch {
            XCTFail("Expected APIError, but got: \(error)")
        }
    }
    
    func testFetchEmptyList() async throws {
        
        let mockNetworkClient = MockNetworkClient()
        let products = [Item]()
        let responseData = try JSONEncoder().encode(products)
        mockNetworkClient.responseData = responseData
        let apiService = StoreAPIService(networkClient: mockNetworkClient)
        
        let fetchedProducts = try await apiService.fetchProducts()
        
        XCTAssertEqual(fetchedProducts.count, 0)
    }
}
