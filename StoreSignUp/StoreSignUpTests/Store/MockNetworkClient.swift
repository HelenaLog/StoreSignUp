import Foundation

final class MockNetworkClient: NetworkClient {
    
    // MARK: Properties
    
    var responseData: Data?
    var responseError: Error?
    var responseStatusCode: Int = 200
    
    // MARK: Methods
    
    func sendRequest<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        try await Task.sleep(nanoseconds: 100_000_000)
        
        if let error = responseError {
            throw error
        }

        guard let data = responseData else {
            throw APIError.network(NSError(domain: "No data", code: -1))
        }
        
        guard (200...299).contains(responseStatusCode) else {
            throw APIError.invalidResponse(statusCode: responseStatusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}
