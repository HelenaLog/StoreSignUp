import UIKit

final class RegistrationAssembly {
    
    static func assembly() -> UIViewController {
        let view = RegistrationViewController()
        let validator = RegistrationValidator()
        let storageService = StorageService()
        let interactor = RegistrationInteractor(validator: validator, storageService: storageService)
        let router = RegistrationRouter(transitionHandler: view)
        let presenter = RegistrationPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
