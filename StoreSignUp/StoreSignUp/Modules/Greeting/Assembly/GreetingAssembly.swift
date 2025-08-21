import UIKit

final class GreetingAssembly {
    
    static func assembly() -> UIViewController {
        let view = GreetingViewController()
        let storageService = StorageService()
        let interactor = GreetingInteractor(storageService: storageService)
        let presenter = GreetingPresenter(
            view: view,
            interactor: interactor
        )
        view.output = presenter
        interactor.output = presenter
        return view
    }
}
