import Foundation

enum RegistrationError: String {
    case invalidName = "Имя должно содержать минимум 2 буквы и не содержать цифры или символы"
    case invalidSurname = "Фамилия должна содержать минимум 2 буквы и не содержать цифры или символы"
    case invalidAge = "Пользователь должен быть старше 15 лет"
    case invalidPassword = "Пароль должен содержать минимум 8 символов, включая заглавные буквы и цифры"
    case passwordMismatch = "Пароли не совпадают"
}
