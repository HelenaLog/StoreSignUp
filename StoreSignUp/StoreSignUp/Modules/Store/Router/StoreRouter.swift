import UIKit

protocol StoreRouterInput: AnyObject {
    func presentGreeting() -> UIViewController
}

final class StoreRouter {
    private unowned var transitionHandler: TransitionHandler
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - StoreRouterInput

extension StoreRouter: StoreRouterInput {
    func presentGreeting() -> UIViewController {
        let view = UIViewController()
        transitionHandler.present(with: view, animated: true)
        return view
    }
}
