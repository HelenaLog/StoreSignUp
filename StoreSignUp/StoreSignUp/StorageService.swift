import Foundation

protocol StorageServiceType {
    func saveUser(name: String) throws
    func isRegistered() -> Bool
    func setRegistered(_ value: Bool)
}

enum StorageError: Error {
    case saveFailure
    case invalidData
}

final class StorageService: StorageServiceType {
    
    private let userDefaults = UserDefaults.standard
    
    func saveUser(name: String) throws {
        guard !name.isEmpty else {
            throw StorageError.invalidData
        }
        userDefaults.set(name, forKey: "username")
    }
    
    func isRegistered() -> Bool {
        userDefaults.bool(forKey: "isRegistered")
    }
    
    func setRegistered(_ value: Bool) {
        userDefaults.set(value, forKey: "isRegistered")
    }
}
