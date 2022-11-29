//
//  GlobalFunctions.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 11/10/20.
//

import SwiftUI

class GlobalFunctions {
    
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
}
