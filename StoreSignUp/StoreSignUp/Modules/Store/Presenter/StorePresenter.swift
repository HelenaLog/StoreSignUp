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
        view.set(.loading)
        interactor.obtainData()
    }
    
    func sendRequest() {
        view.set(.loading)
        interactor.obtainData()
    }
    
    func greetingButtonTap() {
        router.presentGreeting()
    }
}

// MARK: - StoreInteractorOutput

extension StorePresenter: StoreInteractorOutput {
    
    func set(_ products: [Item]) {
        if products.isEmpty {
            view.set(.empty)
        } else {
            self.products = products
            view.set(.success)
        }
    }
    
    func handleError(_ error: Error) {
        let state: StoreState
        
        if let apiError = error as? APIError {
            switch apiError {
            case .network(let error):
                state = .error("Ошибка сети: \(error.localizedDescription)")
            case .invalidResponse(let statusCode):
                state = .error("Неверный ответ, код состояния: \(statusCode)")
            case .decoding(let decodingError):
                state = .error("Ошибка декодирования: \(decodingError.localizedDescription)")
            case .badURL:
                state = .error("Неверный URL")
            }
        } else {
            state = .error("Неизвестная ошибка: \(error.localizedDescription)")
        }
        
        view.set(state)
    }
}

