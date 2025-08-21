import Foundation

protocol StoreViewInput: AnyObject {
    func set(_ state: StoreState)
}

protocol StoreViewOutput: AnyObject {
    var products: [Item] { get set }
    
    func viewDidLoad()
    func sendRequest()
    func greetingButtonTap()
}
