import Foundation

// MARK: - APIServiceType

protocol APIServiceType {
    func fetchProducts() async throws -> [ItemModel]
}

final class StoreAPIService {
    
    // MARK: Private properties
    
    private let networkClient: NetworkClient
    private let baseURL: URL
    
    // MARK: Init
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient(),
        baseURL: URL = URL(string: "https://fakestoreapi.com")!
    ) {
        self.networkClient = networkClient
        self.baseURL = baseURL
    }
}

// MARK: - APIServiceType

extension StoreAPIService: APIServiceType {
    
    func fetchProducts() async throws -> [ItemModel] {
        try await request(StoreEndpoint.products)
    }
}

// MARK: - Private Methods

private extension StoreAPIService {
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> [T] {
        guard let url = URL(string: endpoint.path, relativeTo: baseURL) else {
            throw APIError.badURL
        }
        print(url)
        let request = NetworkRequest(url: url)
        return try await networkClient.sendRequest(request)
    }
}

struct ItemModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
}
