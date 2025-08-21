import Foundation

protocol StorageServiceType {
    func saveUser(name: String) throws
    func getUserName() throws -> String
    func isRegistered() -> Bool
    func setRegistered(_ value: Bool)
}

enum StorageError: Error {
    case saveFailure
    case invalidData
    case nameNotFound
}

final class StorageService: StorageServiceType {
    
    private let userDefaults = UserDefaults.standard
    
    func saveUser(name: String) throws {
        guard !name.isEmpty else {
            throw StorageError.invalidData
        }
        userDefaults.set(name, forKey: "username")
    }
    
    func getUserName() throws -> String {
        guard let name = userDefaults.string(forKey: "username"), !name.isEmpty else {
            throw StorageError.nameNotFound
        }
        return name
    }
    
    func isRegistered() -> Bool {
        userDefaults.bool(forKey: "isRegistered")
    }
    
    func setRegistered(_ value: Bool) {
        userDefaults.set(value, forKey: "isRegistered")
    }
}
