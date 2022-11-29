//
//  UserDetailView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 06/10/20.
//

import SwiftUI

struct UserDetailsRow: View {
    var icon: String
    var placeholder: String
    @Binding var text: String
    @Binding var textFieldIsFocused: Bool
    
    private struct Style {
        static let icon: CGSize = CGSize(width: 44.0, height: 44.0)
        static let iconShadowRadius: CGFloat = 5.0
        static let iconShadowLeadingOffset: CGFloat = 16.0
        static let textFieldHeight: CGFloat = 44.0
        static let imageIconCornerRadius: CGFloat = 16.0
    }
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Style.icon.width, height: Style.icon.height, alignment: .center)
                .background(Color.white)
                .foregroundColor(Colors.Palette.indigoDye.color)
                .clipShape(RoundedRectangle(cornerRadius: Style.imageIconCornerRadius, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: Style.iconShadowRadius, x: 0.0, y: Style.iconShadowRadius)
                .padding(.leading, Style.iconShadowLeadingOffset)
            
            if icon == "password" {
                SecureField(placeholder.uppercased(), text: $text)
                    .keyboardType(.default)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: Style.textFieldHeight)
                    .onTapGesture {
                        self.textFieldIsFocused = true
                }
            } else {
                TextField(placeholder.uppercased(), text: $text)
                    .keyboardType(icon == "email" ? .emailAddress : icon == "age" ? .numberPad : .default)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: Style.textFieldHeight)
                    .onTapGesture {
                        self.textFieldIsFocused = true
                }
            }
        }
    }
}


struct UserDetailsRow_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsRow(icon: "", placeholder: "", text: .constant(""), textFieldIsFocused: .constant(false))
    }
}
