//
//  Student.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 08/10/20.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Student: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var fullName: String
    var email: String
    var password: String
    var age: String
    
    enum CodingKeys: String, CodingKey {
        case age
        case password
        case email
        case fullName = "full_Name"
    }
}

