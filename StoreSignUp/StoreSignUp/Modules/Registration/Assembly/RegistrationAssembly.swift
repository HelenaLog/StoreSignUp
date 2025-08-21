import UIKit

final class RegistrationAssembly {
    
    static func assembly() -> UIViewController {
        let view = RegistrationViewController()
        let validator = RegistrationValidator()
        let interactor = RegistrationInteractor(validator: validator)
        let router = RegistrationRouter()
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
