import Foundation

enum APIError: Error {
    case badURL
    case invalidResponse(statusCode: Int)
    case decoding(Error)
    case network(Error)
}
