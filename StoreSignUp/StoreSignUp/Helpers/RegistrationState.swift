import Foundation

enum RegistrationState {
    case initial
    case valid
    case invalid([String])
    case error(String)
}
