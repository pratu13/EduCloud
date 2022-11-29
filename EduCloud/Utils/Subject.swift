//
//  Subject.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 02/10/20.
//

import SwiftUI

struct Subject {
    
    enum Subjects: String, CaseIterable, Identifiable {
        var id: UUID {
           return UUID()
        }
    
        case maths
        case english
        case science
        case none
        
        var color: Color {
            switch self{
            case .maths:
                return Colors.Palette.sapphireBlue.color
            case .english:
                return Colors.Palette.ruberRed.color
            case .science:
                return Colors.Palette.mediumTurquoise.color
            case .none:
                return Color.black
            }
        }
        
        var image: Image {
            switch self{
            case .maths:
                return Image("maths")
            case .english:
                return Image("english")
            case .science:
                return Image("science")
            case .none:
                return Image("")
            }
        }
    }
}

let subjects = [Subject.Subjects.maths, Subject.Subjects.english, Subject.Subjects.science]
