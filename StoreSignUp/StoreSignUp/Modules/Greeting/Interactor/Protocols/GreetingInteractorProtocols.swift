import Foundation

protocol GreetingInteractorInput: AnyObject {
    func loadData()
}

protocol GreetingInteractorOutput: AnyObject {
    func set(_ name: String)
    func handleError(_ error: Error)
}
