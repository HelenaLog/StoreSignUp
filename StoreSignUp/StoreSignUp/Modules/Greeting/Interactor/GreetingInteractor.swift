import Foundation

final class GreetingInteractor {
    
    weak var output: GreetingInteractorOutput?
    
}

// MARK: - GreetingInteractorInput

extension GreetingInteractor: GreetingInteractorInput {
    func loadData() {}
}
