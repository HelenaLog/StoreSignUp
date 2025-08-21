import UIKit

protocol StoreRouterInput: AnyObject {
    func presentGreeting()
}

final class StoreRouter {
    
    // MARK: Public Properties
    
    weak var transitionHandler: TransitionHandler?
    
    // MARK: Init
    
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }
}

// MARK: - StoreRouterInput

extension StoreRouter: StoreRouterInput {
    func presentGreeting() {
        let view = GreetingAssembly.assembly()
        transitionHandler?.present(with: view, animated: true)
    }
}
