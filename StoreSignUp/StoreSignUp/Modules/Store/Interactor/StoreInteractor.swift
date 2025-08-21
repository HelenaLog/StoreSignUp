import Foundation

final class StoreInteractor {
    
    // MARK: Public Properties
    
    weak var output: StoreInteractorOutput?
    
    // MARK: Private Properties
    
    private let apiService: APIServiceType
    
    // MARK: Init
    
    init(apiService: APIServiceType) {
        self.apiService = apiService
    }
}

// MARK: - StoreInteractorInput

extension StoreInteractor: StoreInteractorInput {
    
    func obtainData() {
        Task {
            do {
                let data = try await apiService.fetchProducts()
                await MainActor.run {
                    output?.set(data)
                }
            } catch {
                await MainActor.run {
                    output?.handleError(error)
                }
            }
        }
    }
}
