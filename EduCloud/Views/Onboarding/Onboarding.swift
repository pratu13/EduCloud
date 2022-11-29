//
//  Signup.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 08/10/20.
//

import SwiftUI
import Foundation

class Onboarding {
    
    enum Status  {
        case success(String)
        case failure(String)
        
        var alertTitle: String {
            switch self {
            case .success:
                return "Yayy!!"
            case .failure( _):
                return "Opps!!"
            }
        }

        var alertSubtitle: String {
            switch self {
            case .success(let message):
                return message
            case .failure(let error):
                return error
            }
        }
        
        var image: Image {
            switch self {
            case .success:
                return Image("yay")
            case .failure(let error):
                if error.contains("password" ) {
                    return Image("wrong-password")
                } else if error.contains("email") {
                    return Image("wrong-email")
                } else {
                    return Image("wrong")
                }
            }
        }
    }
}

//MARK:- Helpers to validate the correct information during signup/login
extension Onboarding {
    
    static func validateField(with name: String? = nil, age: String? = nil, email: String, password: String) -> String? {
        
        if (name?.trimmingCharacters(in: .whitespacesAndNewlines)) == "" || ((age?.trimmingCharacters(in: .whitespacesAndNewlines)) == "") || email.trimmingCharacters(in: .whitespacesAndNewlines) == ""  || password.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill all the details"
        }
 
        if !isValid(email) {
            return "The email's format is incorrect"
        }
        
        if isPasswordValid(password) {
            return "Please make sure the password is strong, containing atleast 8 characters, a special character and a number"
        }

        return nil
    }
    
    static func isPasswordValid(_ password: String) -> Bool {
        let passwordPattern: String = ""
        return password.range(of: passwordPattern, options: .regularExpression) == nil ? false : true
        
    }
    
    static func isValid(_ email: String) -> Bool {
        let pattern: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let result = email.range(of: pattern, options: .regularExpression)
        return result == nil ? false : true
    }
}
