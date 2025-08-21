import Foundation

enum Regex: String {
    case name = "^[A-Za-zА-Яа-я]{2,}$"
    case password = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
}

protocol ValidatorType {
    func validate(
        name: String,
        surname: String,
        birthDate: Date,
        password: String,
        repeatPassword: String
    ) -> [String]
}

final class RegistrationValidator: ValidatorType {
    
    func validate(
        name: String,
        surname: String,
        birthDate: Date,
        password: String,
        repeatPassword: String
    ) -> [String] {
        
        if name.isEmpty || name.range(of: Regex.name.rawValue, options: .regularExpression) == nil {
            return [StringConstants.Error.invalidName]
        }
        
        if surname.isEmpty || surname.range(of: Regex.name.rawValue, options: .regularExpression) == nil {
            return [StringConstants.Error.invalidSurname]
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        if ageComponents.year == nil || ageComponents.year! < 15 {
            return [StringConstants.Error.invalidAge]
        }
        
        if password.range(of: Regex.password.rawValue, options: .regularExpression) == nil {
            return [StringConstants.Error.invalidPassword]
        }
        
        if repeatPassword != password {
            return [StringConstants.Error.passwordMismatch]
        }
        
        return []
    }
}

// MARK: - Constants

private extension RegistrationValidator {
    
    // MARK: StringConstants
    
    enum StringConstants {
        
        // MARK: Error
        
        enum Error {
            static let invalidName = "Имя должно содержать минимум 2 буквы и не содержать цифры или символы"
            static let invalidSurname = "Фамилия должна содержать минимум 2 буквы и не содержать цифры или символы"
            static let invalidAge = "Пользователь должен быть старше 15 лет"
            static let invalidPassword = "Пароль должен содержать минимум 8 символов, включая заглавные буквы и цифры"
            static let passwordMismatch = "Пароли не совпадают"
        }
    }
}
