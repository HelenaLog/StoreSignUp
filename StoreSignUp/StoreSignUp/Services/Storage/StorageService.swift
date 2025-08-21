import Foundation

protocol StorageServiceType {
    func saveUser(name: String) throws
    func getUserName() throws -> String
    func isRegistered() -> Bool
    func setRegistered(_ value: Bool)
}

final class StorageService {
    
    // MARK: Private Properties
    
    private let userDefaults = UserDefaults.standard
}

// MARK: - StorageServiceType

extension StorageService: StorageServiceType {
    
    func saveUser(name: String) throws {
        guard !name.isEmpty else {
            throw StorageError.invalidData
        }
        userDefaults.set(name, forKey: StorageKey.username.rawValue)
    }
    
    func getUserName() throws -> String {
        guard let name = userDefaults.string(forKey: StorageKey.username.rawValue), !name.isEmpty else {
            throw StorageError.nameNotFound
        }
        return name
    }
    
    func isRegistered() -> Bool {
        userDefaults.bool(forKey: StorageKey.isRegistered.rawValue)
    }
    
    func setRegistered(_ value: Bool) {
        userDefaults.set(value, forKey: StorageKey.isRegistered.rawValue)
    }
}
