import Foundation

enum RegistrationState {
    case initial
    case valid
    case invalid([String])
    case loading
    case success
    case error(String)
}
