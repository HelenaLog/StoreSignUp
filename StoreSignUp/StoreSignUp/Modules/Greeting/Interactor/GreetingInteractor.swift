import Foundation

final class GreetingInteractor {
    
    weak var output: GreetingInteractorOutput?
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
