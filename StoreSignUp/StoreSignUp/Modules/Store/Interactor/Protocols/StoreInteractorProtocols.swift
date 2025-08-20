import Foundation

protocol StoreInteractorInput: AnyObject {
    func obtainData()
}

protocol StoreInteractorOutput: AnyObject {
    func set(_ products: [Item])
}
