import UIKit

protocol RegistrationRouterInput {
    func showStoreModule()
}

final class RegistrationRouter {
    private unowned var transitionHandler: TransitionHandler
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - RegistrationRouterInput

extension RegistrationRouter: RegistrationRouterInput {
    
    func showStoreModule() {
        let view = StoreAssembly.assembly()
        transitionHandler.push(with: view, animated: true)
    }
}
