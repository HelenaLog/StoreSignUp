import Foundation

final class RegistrationInteractor {
    
    weak var output: RegistrationInteractorOutput?
    private let validator: ValidatorType
    
    init(validator: ValidatorType) {
        self.validator = validator
    }
}

// MARK: - RegistrationInteractorInput

extension RegistrationInteractor: RegistrationInteractorInput {
    
    func validateData(
        name: String,
        surname: String,
        birthDate: Date,
        password: String,
        repeatPassword: String
    ) {
        let errors = validator.validate(
            name: name,
            surname: surname,
            birthDate: birthDate,
            password: password,
            repeatPassword: repeatPassword
        )
        
        output?.setResult(errors)
    }
    
    func saveData(name: String) {
        print("saveData")
    }
    
    func checkSession() {
        print("checkSession")
    }
}

// MARK: - Private Methods

private extension RegistrationInteractor {}
