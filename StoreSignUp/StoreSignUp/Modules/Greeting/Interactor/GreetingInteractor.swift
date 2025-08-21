import Foundation

final class GreetingInteractor {
    
    // MARK: Public Properties
    
    weak var output: GreetingInteractorOutput?
    
    // MARK: Private Properties
    
    private let storageService: StorageServiceType
    
    // MARK: Init
    
    init(storageService: StorageServiceType) {
        self.storageService = storageService
    }
}

// MARK: - GreetingInteractorInput

extension GreetingInteractor: GreetingInteractorInput {
    
    func loadData() {
        do {
            let name = try storageService.getUserName()
            output?.set(name)
        } catch  {
            output?.handleError(error)
        }
    }
}
