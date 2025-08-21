import Foundation

protocol GreetingViewInput: AnyObject {
    func showGreeting(_ text: String)
    func showError(_ error: String)
}

protocol GreetingViewOutput: AnyObject {
    func viewDidLoad()
}
