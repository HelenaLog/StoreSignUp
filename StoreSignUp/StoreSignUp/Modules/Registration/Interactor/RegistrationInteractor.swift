import Foundation

final class RegistrationInteractor {
    
    weak var output: RegistrationInteractorOutput?
    private let validator: ValidatorType
    private let storageService: StorageServiceType
    
    // MARK: Init
    
    init(
        validator: ValidatorType,
        storageService: StorageServiceType
    ) {
        self.validator = validator
        self.storageService = storageService
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
        do {
            try storageService.saveUser(name: name)
            storageService.setRegistered(true)
            output?.setResult([])
        } catch {
            output?.handleError(error)
        }
    }
    
    func checkSession() {
        let isRegistered = storageService.isRegistered()
        output?.setSessionStatus(isRegistered)
    }
}

// MARK: - Private Methods

private extension RegistrationInteractor {}
