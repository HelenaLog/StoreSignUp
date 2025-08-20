import UIKit

final class StoreViewController: UIViewController {
    
    var output: StoreViewOutput!
    
    // MARK: Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(StoreItemCell.self, forCellReuseIdentifier: StoreItemCell.cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var greetingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringConstants.Button.greeting, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = PointConstants.Button.cornerRadius
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: PointConstants.Font.size, weight: .bold)
        button.addTarget(self, action: #selector(greetingButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        setup()
    }
}

// MARK: - StoreViewInput

extension StoreViewController: StoreViewInput {
    
    func set(_ state: StoreState) {
        switch state {
        case .success:
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            emptyView.isHidden = true
            tableView.reloadData()
        case .empty:
            activityIndicator.stopAnimating()
            self.output.products = []
            emptyView.isHidden = false
            tableView.isHidden = true
        }
    }
}

// MARK: - UITableViewDelegate

extension StoreViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension StoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StoreItemCell.cellId,
            for: indexPath) as? StoreItemCell
        else { return UITableViewCell() }
        let item = output.products[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - Private Methods

private extension StoreViewController {
    
    @objc
    func greetingButtonTap() {
        print("greetingButtonTap")
    }
    
    func setup() {
        embedViews()
        setupAppearance()
        setupBehavior()
        setupLayout()
        setupRefresh()
    }
    
    func setupRefresh() {
        emptyView.onRefresh = { [weak self] in
            self?.output.sendRequest()
        }
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemBackground
    }
    
    func setupBehavior() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func embedViews() {
        [
            tableView,
            greetingButton,
            activityIndicator,
            emptyView
        ].forEach { view.addSubview($0) }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            greetingButton.heightAnchor.constraint(equalToConstant: PointConstants.Button.height),
            greetingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PointConstants.Spacing.leading),
            greetingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: PointConstants.Spacing.trailing),
            greetingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: PointConstants.Spacing.bottom),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: greetingButton.topAnchor, constant: PointConstants.Spacing.bottom),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - Constants

private extension StoreViewController {
    
    // MARK: PointConstants
    
    enum PointConstants {
        
        // MARK: Font
        
        enum Font {
            static let size: CGFloat = 18
        }
        
        // MARK: Spacing
        
        enum Spacing {
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let bottom: CGFloat = -16
        }
        
        // MARK: Button
        
        enum Button {
            static let height: CGFloat = 45
            static let cornerRadius: CGFloat = 10
        }
    }
    
    // MARK: StringConstants
    
    enum StringConstants {
        
        // MARK: Button
        
        enum Button {
            static let greeting = "Приветствие"
        }
    }
}
