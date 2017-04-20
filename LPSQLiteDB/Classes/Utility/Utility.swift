//
//  Utility.swift
//  LPSQLiteDB
//
//  Created by Lomesh Pansuriya on 19/04/17.
//  Copyright © 2017 Lomesh Pansuriya. All rights reserved.
//

import UIKit

// MARK: - Regex constants
struct Regex {
    // Password strength
    struct Password {
        //Should contains one or more letters
        static let oneLetter: String = "^(?=.*[A-Za-z]).*$"
        //Should contains one or more uppercase letters
        static let oneUppercase: String = "^(?=.*[A-Z]).*$"
        //Should contains one or more lowercase letters
        static let oneLowercase: String = "^(?=.*[a-z]).*$"
        //Should contains one or more number
        static let oneDigit: String = "^(?=.*[0-9]).*$"
        //Should contains one or more symbol
        static let oneSpecialCharacter: String = "^(?=.*[^A-Za-z0-9]).*$"
    }
    // Email validation
    static let email: String = "^(?:(?:[\\w`~!#$%^&*\\-=+;:{}'|,?\\/]+(?:(?:\\.(?:\"(?:\\\\?[\\w`~!#$%^&*\\-=+;:{}'|,?\\/\\.()<>\\[\\] @]|\\\\\"|\\\\\\\\)*\"|[\\w`~!#$%^&*\\-=+;:{}'|,?\\/]+))*\\.[\\w`~!#$%^&*\\-=+;:{}'|,?\\/]+)?)|(?:\"(?:\\\\?[\\w`~!#$%^&*\\-=+;:{}'|,?\\/\\.()<>\\[\\] @]|\\\\\"|\\\\\\\\)+\"))@(?:[a-zA-Z\\d\\-]+(?:\\.[a-zA-Z\\d\\-]+)*|\\[\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\])$"
}

// MARK: - Utility class
class Utility {
    
    static let shared = Utility()
    
    func isValidEmail(_ email: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", Regex.email)
        return emailTest.evaluate(with: email)
    }
    
    func isValidUserName(userName:String) -> Bool {
        for chr in userName.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ")) {
                return false
            }
        }
        return true
    }
}
