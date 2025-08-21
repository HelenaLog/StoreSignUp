import Foundation

final class StoreInteractor {
    
    weak var output: StoreInteractorOutput?
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
