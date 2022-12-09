//
//  Validator.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 07.12.2022.
//

import Foundation

// for failure and success results
enum Alert {
    case success
    case failure
    case error
}

// For success or failure of validation with alert message
enum Valid {
    case success
    case failure(Alert, AlertMessages)
}

enum ValidationType {
    case email
    case password
}

enum RegEx: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}" // Email
    case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$" // Minimum 8 characters at least 1 Alphabet and 1 Number:
}

enum AlertMessages: String {
     case inValidEmail = "Invalid Email"
     case inValidPSW = """
    Invalid Password. Password must contain:
    - minimum 8 characters
    - at least 1 alphabet
    - at least 1 number
    """

     case emptyEmail = "Empty Email"
     case emptyPSW = "Empty Password"

     func localized() -> String {
        NSLocalizedString(self.rawValue, comment: "")
     }
}

class Validator: NSObject {
    public static let shared = Validator()

    func validate(values: (type: ValidationType, inputValue: String)...) -> Valid {
        for valueToBeChecked in values {
            switch valueToBeChecked.type {
            case .email:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .emptyEmail, .inValidEmail)) {
                    return tempValue
                }

            case .password:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .emptyPSW, .inValidPSW)) {
                    return tempValue
                }
            }
        }

        return .success
    }

    func isValidString(_ input: (text: String, regex: RegEx, emptyAlert: AlertMessages, invalidAlert: AlertMessages)) -> Valid? {
        if input.text.isEmpty {
            return .failure(.error, input.emptyAlert)
        } else if isValidRegEx(input.text, input.regex) != true {
            return .failure(.error, input.invalidAlert)
        }
        return nil
    }

    func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
        let stringTest = NSPredicate(format: "SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
    }
}
