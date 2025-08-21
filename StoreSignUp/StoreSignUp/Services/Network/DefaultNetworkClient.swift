import Foundation

// MARK: - NetworkClient

protocol NetworkClient {
    func sendRequest<T: Decodable>(_ request: NetworkRequest) async throws -> T
}

final class DefaultNetworkClient: NetworkClient {

    // MARK: Private properties
    
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    // MARK: Init
    
    init(
        urlSession: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
}

extension DefaultNetworkClient {
    
    func sendRequest<T: Decodable>(_ request: NetworkRequest) async throws -> T {
        let urlRequest = URLRequest(url: request.url)
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.network(NSError(domain: "Invalid response", code: -1))
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse(statusCode: httpResponse.statusCode)
            }
            
            return try decoder.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            throw APIError.decoding(decodingError)
        } catch {
            throw APIError.network(error)
        }
    }
}
