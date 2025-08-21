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

    func registrationButtonTapped(name: String) {
        interactor.saveData(name: name)
    }
}

// MARK: - RegistrationInteractorOutput

extension RegistrationPresenter: RegistrationInteractorOutput {
    
    func setResult(_ errors: [String]) {
        if errors.isEmpty {
            view.set(.valid)
        } else {
            view.set(.invalid(errors))
        }
    }
}
