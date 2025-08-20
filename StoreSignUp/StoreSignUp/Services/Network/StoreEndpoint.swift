import Foundation

enum StoreEndpoint: Endpoint {
    case products
    
    var path: String {
        switch self {
        case .products:
            "/products"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .products: .GET
        }
    }
}
