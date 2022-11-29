//
//  LoginView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 05/10/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @Binding var loginButtonTapped: Bool
    @Binding var textFieldIsFocused: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var error: String
    @Binding var showAlert: Bool
    @Binding var showSuccessAlert: Bool
    @Binding var successMessage: String
    @EnvironmentObject var user: User
    
    private struct Style {
        static let viewHeight: CGFloat = 136.0
        static let shadowRadius: CGFloat = 20.0
        static let cornerRadius: CGFloat = 30.0
        static let viewXOffset: CGFloat = screen.width + 200.0
        static let viewYOffset: CGFloat = screen.midY - 10.0
        static let textFieldFocusedYOffset: CGFloat = 200.0
        static let dividerLeadingPadding: CGFloat = 80.0
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous)
                .foregroundColor(Color.white)
                .frame(width: screen.width, height: screen.height/2)
            
            Image("onlineLearning")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.white)
                .frame(width: screen.width, height: screen.height/2, alignment: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius,style: .continuous))
                
            VStack {
                UserDetailsRow(icon: "email", placeholder: "Your Email", text: $email, textFieldIsFocused: $textFieldIsFocused)
                
                Divider().padding(.leading, Style.dividerLeadingPadding)
                
                UserDetailsRow(icon: "password", placeholder: "Your Password", text: $password, textFieldIsFocused: $textFieldIsFocused)
            }
            .frame(height: Style.viewHeight)
            .frame(maxWidth: .infinity)
            .background(BlurView(style: .systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.15), radius: Style.shadowRadius, x: 0, y: Style.shadowRadius)
            .offset(y: Style.viewYOffset)
            
            if showAlert {
                AlertView(show: $showAlert, status: .failure(error))
            }
            
            if showSuccessAlert {
                AlertView(show: $showSuccessAlert, status: .success(successMessage))
            }
        }
        .offset(y: textFieldIsFocused ? -Style.textFieldFocusedYOffset : 0.0)
        .scaleEffect(loginButtonTapped ? 1 : 0.0)
        .offset(x: loginButtonTapped ? 0.0 : Style.viewXOffset)
        .animation(.spring(response: 0.70, dampingFraction: 0.8, blendDuration: 0.0))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginButtonTapped: .constant(true), textFieldIsFocused: .constant(false), email: .constant(""), password: .constant(""), error: .constant(""), showAlert: .constant(false), showSuccessAlert: .constant(false), successMessage: .constant(""))
            .environmentObject(User())
    }
}

//MARK:- OnboardingMethodListener
extension LoginView: OnboardingMethodListener {
    
    func startFlow()  {
        let errorMessage = Onboarding.validateField(email: email, password: password)
        if errorMessage == nil {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard error == nil else {
                    self.error = error?.localizedDescription ?? "Something went wrong, error occurred while creating a user. Please Try Again."
                    loginOrSignup(with: .failure(self.error))
                    return 
                }
                self.showSuccessAlert = true
                successMessage = "Logging you in, Hold up."
                loginOrSignup(with: .success(successMessage), result: result)
            }
        } else {
            loginOrSignup(with: .failure(errorMessage ?? ""))
        }
    }
    
    func loginOrSignup(with status: Onboarding.Status, result: AuthDataResult? = nil) {
        switch status {
        case .success:
            self.password = ""
            self.email = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showSuccessAlert = false
                self.user.userLoggedIn = true
            }
            
        case .failure(let error):
            self.error = error
            self.showAlert = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showAlert = false
            }
        }
        self.textFieldIsFocused = false
        GlobalFunctions.hideKeyboard()
    }
}
