import Foundation

final class RegistrationPresenter {
    
    private unowned var view: RegistrationViewInput
    private let interactor: RegistrationInteractorInput
    private let router: RegistrationRouter
    
    // MARK: Init
    
    init(
        view: RegistrationViewInput,
        interactor: RegistrationInteractorInput,
        router: RegistrationRouter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {

    func viewDidLoad() {
        view.set(.initial)
        interactor.checkSession()
    }

    func registrationButtonTapped(name: String) {
        interactor.saveData(name: name)
    }
    
    func regButton(
        name: String,
        surname: String,
        birthDate: Date,
        password: String,
        repeatPassword: String
    ) {
        interactor.validateData(
            name: name,
            surname: surname,
            birthDate: birthDate,
            password: password,
            repeatPassword: repeatPassword
        )
    }
    
    func showStoreModule() {
        // router -> store screen
    }
}

// MARK: - RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func setResult(_ errors: [String]) {
        if let firstError = errors.first {
            view.set(.invalid([firstError]))
        } else {
            view.set(.valid)
            showStoreModule()
        }
    }
    
    func handleError(_ error: Error) {
        let state: RegistrationState
        if let storageError = error as? StorageError {
            switch storageError {
            case .saveFailure:
                state = .error("Не удалось сохранить данные пользователя")
            case .invalidData:
                state = .error("Неверные данные для сохранения")
            }
        } else {
            state = .error("Неизвестная ошибка: \(error.localizedDescription)")
        }
        view.set(state)
    }
    
    func setSessionStatus(_ isRegistered: Bool) {
        if isRegistered {
            // router -> store screen
            print("router -> store screen")
        } else {
            view.set(.initial)
        }
    }
}
