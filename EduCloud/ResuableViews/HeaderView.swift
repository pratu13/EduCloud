//
//  HeaderView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 20/09/20.
//

import SwiftUI

struct HeaderView: View {
    @Binding var menuButtonTapped: Bool
    var profile: String = ""
    @EnvironmentObject var user: User
    
    var body: some View {
        VStack {
            HStack {
                if self.user.userLoggedIn {
                    Image("profile_temp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .opacity(menuButtonTapped ? 0.0 : 1.0)
                        .onTapGesture {
                            self.menuButtonTapped = true
                        }
                } else {
                    LottieView(filename: "portraits")
                        .scaleEffect(1.3)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .opacity(menuButtonTapped ? 0.0 : 1.0)
                        .onTapGesture {
                            self.menuButtonTapped = true
                        }
                }
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            Spacer()
        }
        .padding(.top, edge?.top)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(menuButtonTapped: .constant(false))
    }
}
