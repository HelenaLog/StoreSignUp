import UIKit

final class GreetingViewController: UIViewController {
    
    var output: GreetingViewOutput!
    
    // MARK: Private Properties
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.textColor = .label
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: PointConstants.Font.size)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        setupAppearance()
        embedView()
        setupLayout()
    }
}

// MARK: - GreetingViewInput

extension GreetingViewController: GreetingViewInput {
    
    func showGreeting(_ text: String) {
        greetingLabel.text = text
    }
    
    func showError(_ error: String) {
        greetingLabel.text = error
    }
}

// MARK: - Private Methods

private extension GreetingViewController {
    
    func setupAppearance() {
        view.backgroundColor = .white
    }
    
    func embedView() {
        view.addSubview(greetingLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Constants

private extension GreetingViewController {
    
    // MARK: PointConstants
    
    enum PointConstants {
        
        // MARK: Font
        
        enum Font {
            static let size: CGFloat = 18
        }
    }
}
