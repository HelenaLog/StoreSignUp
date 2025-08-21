import UIKit

final class RegistrationViewController: UIViewController {
    
    var output: RegistrationViewOutput!
    
    // MARK: Private Properties
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = StringConstants.Format.dateFormat
        return formatter
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.Placeholder.enterName
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.Placeholder.enterSurname
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var birthDateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.Placeholder.enterBirthDate
        textField.borderStyle = .roundedRect
        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.Placeholder.enterPassword
        textField.isSecureTextEntry = true
        textField.rightViewMode = .always
        textField.borderStyle = .roundedRect
        textField.textContentType = .none
        textField.returnKeyType = .next
        textField.rightView = showPasswordButton
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.Placeholder.enterRepeatPassword
        textField.isSecureTextEntry = true
        textField.rightViewMode = .always
        textField.borderStyle = .roundedRect
        textField.textContentType = .none
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.rightView = showRepeatPasswordButton
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringConstants.Button.registration, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = PointConstants.Button.cornerRadius
        button.tintColor = .white
        button.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: StringConstants.Icon.eyeSlash), for: .normal)
        button.setImage(UIImage(systemName: StringConstants.Icon.eye), for: .selected)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var showRepeatPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: StringConstants.Icon.eyeSlash), for: .normal)
        button.setImage(UIImage(systemName: StringConstants.Icon.eye), for: .selected)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(showConfirmPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: StringConstants.Format.ru)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = PointConstants.Spacing.stack
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var flexibleSpace = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )
    
    private lazy var doneButton = UIBarButtonItem(
        title: StringConstants.Button.done,
        style: .done,
        target: self,
        action: #selector(doneButtonTapped)
    )
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        return toolbar
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setup()
    }
    
    // MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            surnameTextField.becomeFirstResponder()
        case surnameTextField:
            birthDateTextField.becomeFirstResponder()
        case birthDateTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            repeatPasswordTextField.becomeFirstResponder()
        case repeatPasswordTextField:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput {
    
    func set(_ state: RegistrationState) {
        switch state {
        case .initial:
            registrationButton.isEnabled = false
            errorLabel.text = nil
        case .valid:
            registrationButton.isEnabled = true
            errorLabel.text = nil
        case .invalid(let errors):
            registrationButton.isEnabled = false
            errorLabel.text = errors.first
        case .error(let error):
            registrationButton.isEnabled = false
            errorLabel.text = error
        }
    }
}

// MARK: - TransitionHandler

extension RegistrationViewController: TransitionHandler {}

// MARK: - Private Methods

private extension RegistrationViewController {
    
    @objc
    func showPassword() {
        passwordTextField.isSecureTextEntry.toggle()
        showPasswordButton.isSelected.toggle()
    }
    
    @objc
    func showConfirmPassword() {
        repeatPasswordTextField.isSecureTextEntry.toggle()
        showRepeatPasswordButton.isSelected.toggle()
    }
    
    @objc
    func registrationButtonTapped() {
        output.registrationButtonTapped(name: nameTextField.text ?? String())
    }
    
    @objc
    func textFieldDidChange() {
        output.validateData(
            name: nameTextField.text ?? String(),
            surname: surnameTextField.text ?? String(),
            birthDate: dateFormatter.date(from: birthDateTextField.text ?? String()) ?? Date(),
            password: passwordTextField.text ?? String(),
            repeatPassword: repeatPasswordTextField.text ?? String()
        )
    }
    
    @objc
    func doneButtonTapped() {
        birthDateTextField.text = dateFormatter.string(from: datePicker.date)
        birthDateTextField.resignFirstResponder()
    }
    
    @objc
    func keyboardDismiss() {
        view.endEditing(true)
    }
}

// MARK: - UI Configuration

private extension RegistrationViewController {
    
    func setup() {
        embedViews()
        setupLayout()
        setupAppearance()
        setupBehavior()
        setupTapGestureRecognizer()
        addKeyboardObservers()
        setupDatePicker()
    }
    
    func setupDatePicker() {
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -15, to: Date())
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
    }
    
    func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    func setupAppearance() {
        view.backgroundColor = .white
        navigationItem.title = StringConstants.Title.signUp
    }
    
    func embedViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        [
            nameTextField,
            surnameTextField,
            birthDateTextField,
            passwordTextField,
            repeatPasswordTextField,
            registrationButton,
            errorLabel
        ].forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupBehavior() {
        [
            nameTextField,
            surnameTextField,
            birthDateTextField,
            passwordTextField,
            repeatPasswordTextField
        ].forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    func setupLayout() {
        let scrollContentGuide = scrollView.contentLayoutGuide
        let scrollFrameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor, constant: PointConstants.Spacing.top),
            stackView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor, constant: PointConstants.Spacing.leading),
            stackView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor, constant: PointConstants.Spacing.trailing),
            stackView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor, constant: PointConstants.Spacing.bottom),
            registrationButton.heightAnchor.constraint(equalToConstant: PointConstants.Button.height)
        ])
    }
}

// MARK: - Constants

private extension RegistrationViewController {
    
    // MARK: PointConstants
    
    enum PointConstants {
        
        // MARK: Spacing
        
        enum Spacing {
            static let top: CGFloat = 16
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let bottom: CGFloat = -16
            static let stack: CGFloat = 24
        }
        
        // MARK: Button
        
        enum Button {
            static let height: CGFloat = 45
            static let cornerRadius: CGFloat = 10
        }
    }
    
    // MARK: StringConstants
    
    enum StringConstants {
        
        enum Title {
            static let signUp = "SignUp"
        }
        // MARK: Placeholder
        
        enum Placeholder {
            static let enterName = "Введите имя"
            static let enterSurname = "Введите фамилию"
            static let enterBirthDate = "Введите дату рождения"
            static let enterPassword = "Введите пароль"
            static let enterRepeatPassword = "Повторите пароль"
        }
        
        // MARK: Button
        
        enum Button {
            static let registration = "Регистрация"
            static let done = "Готово"
        }
        
        // MARK: Icon
        
        enum Icon {
            static let eyeSlash = "eye.slash.fill"
            static let eye = "eye.fill"
        }
        
        // MARK: Locale
        
        enum Format {
            static let ru = "ru_RU"
            static let dateFormat = "dd.MM.yyyy"
        }
    }
}
