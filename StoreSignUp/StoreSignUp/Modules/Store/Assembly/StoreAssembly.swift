import UIKit

final class StoreAssembly {
    
    static func assembly() -> UIViewController {
        let view = StoreViewController()
        let apiService = StoreAPIService()
        let interactor = StoreInteractor(apiService: apiService)
        let router = StoreRouter(transitionHandler: view)
        let presenter = StorePresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
