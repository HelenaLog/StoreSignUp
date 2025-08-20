import Foundation

final class StorePresenter {
    
    private unowned var view: StoreViewInput
    private let interactor: StoreInteractorInput
    private let router: StoreRouter
    var products = [Item]()
    
    // MARK: Init
    
    init(
        view: StoreViewInput,
        interactor: StoreInteractorInput,
        router: StoreRouter
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - StoreViewOutput

extension StorePresenter: StoreViewOutput {
    
    func viewDidLoad() {
        interactor.obtainData()
    }
}

// MARK: - StoreInteractorOutput

extension StorePresenter: StoreInteractorOutput {
    
    func set(_ products: [Item]) {
        self.products = products
        view.reloadData()
    }
}
