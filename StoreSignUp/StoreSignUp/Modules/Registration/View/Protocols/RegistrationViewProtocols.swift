import Foundation

protocol RegistrationViewInput: AnyObject {
    func set(_ state: RegistrationState)
}

protocol RegistrationViewOutput: AnyObject {
    func viewDidLoad()
    func registrationButtonTapped(name: String)
    func validateData(
        name: String,
        surname: String,
        birthDate: Date,
        password: String,
        repeatPassword: String
    )
}
