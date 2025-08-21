import Foundation

enum Regex: String {
    case name = "^[A-Za-zА-Яа-я]{2,}$"
    case password = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$"
}
