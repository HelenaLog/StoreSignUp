import Foundation

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
            return [RegistrationError.invalidName.rawValue]
        }
        
        if surname.isEmpty || surname.range(of: Regex.name.rawValue, options: .regularExpression) == nil {
            return [RegistrationError.invalidSurname.rawValue]
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: Date())
        if ageComponents.year == nil || ageComponents.year! < PointConstants.BirthDate.age {
            return [RegistrationError.invalidAge.rawValue]
        }
        
        if password.range(of: Regex.password.rawValue, options: .regularExpression) == nil {
            return [RegistrationError.invalidPassword.rawValue]
        }
        
        if repeatPassword != password {
            return [RegistrationError.passwordMismatch.rawValue]
        }
        
        return []
    }
}

// MARK: - Constants

private extension RegistrationValidator {
    
    // MARK: PoinConstants
    
    enum PointConstants {
        
        // MARK: BirthDate
        
        enum BirthDate {
            static let age = 15
        }
    }
}
