import UIKit

protocol StoreRouterInput: AnyObject {
    func presentGreeting()
}

final class StoreRouter {
    private unowned var transitionHandler: TransitionHandler
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - StoreRouterInput

extension StoreRouter: StoreRouterInput {
    func presentGreeting() {
        let view = GreetingAssembly.assembly()
        transitionHandler.present(with: view, animated: true)
    }
}
