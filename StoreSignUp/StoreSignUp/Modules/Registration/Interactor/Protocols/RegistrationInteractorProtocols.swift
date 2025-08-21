import Foundation

protocol RegistrationInteractorInput: AnyObject {
    func validateData(name: String, surname: String, birthDate: Date, password: String, repeatPassword: String)
    func saveData(name: String)
    func checkSession()
}

protocol RegistrationInteractorOutput: AnyObject {
    func setResult(_ errors: [String])
}
