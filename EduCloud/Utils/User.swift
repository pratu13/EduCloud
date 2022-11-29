//
//  User.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 04/10/20.
//

import SwiftUI

class User: ObservableObject {  
    @Published var name: String = ""
    @Published var image: Image = Image("profile_temp")
    @Published var chosenSubject: Subject.Subjects = .none
    @Published var userLoggedIn: Bool = false
    @Published var userSkippedLogin: Bool = false
}
