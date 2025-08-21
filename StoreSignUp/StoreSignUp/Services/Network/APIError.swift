import Foundation

enum APIError: Error {
    case invalidBaseURL
    case badURL
    case invalidResponse(statusCode: Int)
    case decoding(Error)
    case network(Error)
}
