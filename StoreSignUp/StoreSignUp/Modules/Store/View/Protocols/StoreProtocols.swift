import Foundation

protocol StoreViewInput: AnyObject {
    func reloadData()
}

protocol StoreViewOutput: AnyObject {
    var products: [Item] { get set }
    
    func viewDidLoad()
}
