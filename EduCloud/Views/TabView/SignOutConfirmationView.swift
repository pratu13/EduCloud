//
//  SignOutConfirmationView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 21/09/20.
//

import SwiftUI

struct SignOutConfirmationView: View {
    @Binding var signOutButtonTapped: Bool
    @State var confirmButtonTapped: Bool = false
    @State var cancelButtonTapped: Bool = false
    @EnvironmentObject var user: User
    
    enum ConfirmationButtonAction {
        case cancel
        case confirm
    }
    
    var body: some View {
        VStack(spacing: 20.0) {
            Spacer()
            Text("Are you sure, you want to sign out?")
                .bold()
                .font(.title3)
                .multilineTextAlignment(.center)
            Text("You have re-enter your phone number after logging out")
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding()
        .frame(width: screen.width - 100, height: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
        .overlay(
            
            VStack {
                Image("cloud")
                    .resizable()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fill)
                    .scaleEffect(1.9)
                    .offset(y: -80.0)
                
                HStack(spacing: 10.0) {
                    ConfirmationButton(confirmOutButtonTapped: $confirmButtonTapped, cancelOutButtonTapped: $cancelButtonTapped, signOutButtonTapped: $signOutButtonTapped, action: .confirm, title: "Confirm")
                    ConfirmationButton(confirmOutButtonTapped: $confirmButtonTapped, cancelOutButtonTapped: $cancelButtonTapped, signOutButtonTapped: $signOutButtonTapped, action: .cancel, title: "Cancel")
                }
                .offset(y: 50.0)
            }
                )
        }
}

struct SignOutConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        SignOutConfirmationView(signOutButtonTapped: .constant(false))
            .environmentObject(User())
    }
}

struct ConfirmationButton: View {
    @Binding var confirmOutButtonTapped: Bool
    @Binding var cancelOutButtonTapped: Bool
    @Binding var signOutButtonTapped: Bool
    var action: SignOutConfirmationView.ConfirmationButtonAction = .cancel
    var title: String = ""
    @EnvironmentObject var user: User
    
    var body: some View {
        
        Button(action: {
            buttonTapped(with: action)
        }) {
            Text(title)
                .bold()
                .foregroundColor(.white)
                .font(.callout)
        }
        .frame(width: 120, height: 54)
        .background(user.chosenSubject.color)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
    
    private func buttonTapped(with action: SignOutConfirmationView.ConfirmationButtonAction) {
        
        switch action {
        case .cancel:
            self.signOutButtonTapped = false
        case .confirm:
            self.user.userLoggedIn = false
        }
        
    }
}
