import Foundation

final class GreetingPresenter {
    
    // MARK: Public Properties
    
    weak var view: GreetingViewInput?
    
    // MARK: Private Properties
    
    private let interactor: GreetingInteractorInput
    
    // MARK: Init
    
    init(
        view: GreetingViewInput,
        interactor: GreetingInteractorInput
    ) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: - GreetingViewOutput

extension GreetingPresenter: GreetingViewOutput {
    
    func viewDidLoad() {
        interactor.loadData()
    }
}

// MARK: - GreetingInteractorOutput

extension GreetingPresenter: GreetingInteractorOutput {
    func set(_ name: String) {
        let greeting = "Привет, \(name)!"
        view?.showGreeting(greeting)
    }
    
    func handleError(_ error: Error) {
        view?.showError("Не удалось загрузить имя: \(error.localizedDescription)")
    }
}
