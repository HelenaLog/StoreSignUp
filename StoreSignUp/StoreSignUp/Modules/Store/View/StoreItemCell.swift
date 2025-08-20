import UIKit

final class StoreItemCell: UITableViewCell {
    
    static let cellId = StringConstants.id
    
    // MARK: Private Properties
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: PointConstants.Font.size)
        label.textColor = .label
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: PointConstants.Font.size)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
}

// MARK: - Public Methods

extension StoreItemCell {
    
    func configure() {}
}

// MARK: - Private Methods

private extension StoreItemCell {
    
    func embedViews() {
        [
            productImageView,
            titleLabel,
            priceLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PointConstants.Spacing.top),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PointConstants.Spacing.leading),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PointConstants.Spacing.trailing),
            productImageView.heightAnchor.constraint(equalToConstant: PointConstants.Image.height),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: PointConstants.Spacing.top),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PointConstants.Spacing.leading),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PointConstants.Spacing.trailing),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PointConstants.Spacing.top),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: PointConstants.Spacing.leading),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: PointConstants.Spacing.trailing),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: PointConstants.Spacing.bottom)
        ])
    }
}

// MARK: - Constants

private extension StoreItemCell {
    
    // MARK: PointConstants
    
    enum PointConstants {
        
        // MARK: Font
        
        enum Font {
            static let size: CGFloat = 18
        }
        
        // MARK: Spacing
        
        enum Spacing {
            static let top: CGFloat = 16
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let bottom: CGFloat = -16
        }
        
        // MARK: Image
        
        enum Image {
            static let height: CGFloat = 150
        }
    }
    
    // MARK: StringConstants
    
    enum StringConstants {
        static let id = "ItemTableViewCell"
    }
}
