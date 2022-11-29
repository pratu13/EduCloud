//
//  MenuView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 20/09/20.
//

import SwiftUI

struct MenuView: View {
    @Binding var menuButtonTapped: Bool
    @Binding var signOutButtonTapped: Bool
    var profile: String = ""
    var color: Color
    @State var showSubjectView: Bool = false
    @EnvironmentObject var user: User
    
    var body: some View {
        ZStack {
            color
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button(action: {
                        self.menuButtonTapped.toggle()
                    }) {
                        Image("cancel")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    }
                    .frame(width: 40, height: 40, alignment: .center)
                    
                    Spacer()
                }
                .padding(.top, 70)
                .padding()
                
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 20.0) {
                        LottieView(filename: "portraits")
                            .scaleEffect(1.3)
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                            .overlay(Circle().strokeBorder(Color.white))
                
                        Text("")
                            .foregroundColor(.white)
                            .font(.headline)
                            .bold()
                            .frame(width: 150, alignment: .leading)
                    }
                    Spacer()
                }
                .padding()
                
                HStack {
                    VStack(alignment: .leading, spacing: 20.0) {
                        MenuRow(title: "Edit Profile", icon: "navigationArrow")
                            .opacity(user.userSkippedLogin ? 0 : 1.0)
//                        MenuRow(title: "Settings", icon: "navigationArrow")
//                            .opacity(user.userSkippedLogin ? 0 : 1.0)
                        MenuRow(title: "Change Subject", icon: "navigationArrow")
                            .onTapGesture {
                                self.showSubjectView = true
                            }
                            .sheet(isPresented: $showSubjectView) {
                               SubjectView()
                            }
                    }
                    .padding()
                    Spacer()
                }
                
                HStack {
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(
                            HStack {
                                Image(systemName: "person.crop.circle")
                                Text(user.userLoggedIn ? "Sign out" : "Sign In")
                                
                            }
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(user.chosenSubject.color)
                        
                        )
                        .onTapGesture{
                            self.signOutButtonTapped.toggle()
                        }
                        
                    Spacer()
                }
//                .onTapGesture {
//                    self.user.userSkippedLogin = false
//                }
                .padding()
                
                Spacer()
                
            }
            
        }
//        .blur(radius: signOutButtonTapped ? 10.0 : 0.0)
        .disabled(signOutButtonTapped)
        
    }
    
}

struct MenuRow: View {
    var title: String
    var icon: String
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
                .frame(width: 120, alignment: .leading)
            
            Image(icon)
                .resizable()
                .font(.system(size: 15, weight: .bold))
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
    }
}



struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuButtonTapped: .constant(false), signOutButtonTapped: .constant(false), color: .accentColor)
    }
}
