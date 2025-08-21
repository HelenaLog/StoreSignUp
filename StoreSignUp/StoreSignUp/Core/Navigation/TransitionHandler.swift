import UIKit

protocol TransitionHandler: AnyObject {
    func present(
        with viewController: UIViewController,
        animated: Bool
    )
    
    func push(
        with viewController: UIViewController,
        animated: Bool
    )
    
    func dismiss()
}

extension TransitionHandler where Self: UIViewController {
    
    func present(
        with viewController: UIViewController,
        animated: Bool = true
    ) {
        present(viewController, animated: animated)
    }
    
    func push(
        with viewController: UIViewController,
        animated: Bool = true
    ) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func dismiss() {
        dismiss()
    }
}
