import Foundation

protocol RegistrationViewInput: AnyObject {
    func set(_ state: RegistrationState)
}

protocol RegistrationViewOutput: AnyObject {
    func registrationButtonTapped(name: String)
}
