//
//  SignUpView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 30/09/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @Binding var signupButtonTapped: Bool
    @Binding var textFieldIsFocused: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var age: String
    @Binding var showAlert: Bool
    @Binding var showSuccessAlert: Bool
    @Binding var error: String
    @Binding var loginButtonTapped: Bool
    @Binding var successMessage: String
    
    let db = Firestore.firestore()
    
    private struct Style {
        static let shadowRadius: CGFloat = 20.0
        static let cornerRadius: CGFloat = 30.0
        static let viewXOffset: CGFloat = screen.width + 200
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous)
                .frame(maxWidth: .infinity)
                .frame(height: screen.height/3)
                .foregroundColor(Color.clear)
                .overlay(
                    Image("pluto-study")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: screen.width)
                        .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
                        //.scaleEffect(signupButtonTapped ? 1 : 0.0)
                        //.offset(x: signupButtonTapped ? 0.0 : -(Style.viewXOffset))
                        .overlay(
                            SignupFormView(signupButtonTapped: $signupButtonTapped, textFieldIsFocused: $textFieldIsFocused, email: $email, password: $password, name: $name,age: $age)
                        )
                )
        
            if showAlert {
                AlertView(show: $showAlert, status: .failure(error))
            }
            
            if showSuccessAlert {
                AlertView(show: $showSuccessAlert, status: .success(successMessage))
            }
        }
        .scaleEffect(signupButtonTapped ? 1 : 0.0)
        .offset(x: signupButtonTapped ? 0.0 : -(Style.viewXOffset))
        .animation(.spring(response: 0.70, dampingFraction: 0.8, blendDuration: 0.0))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct SignupFormView: View {
    @Binding var signupButtonTapped: Bool
    @Binding var textFieldIsFocused: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var age: String
    
    private struct Style {
        static let shadowRadius: CGFloat = 20.0
        static let cornerRadius: CGFloat = 30.0
        static let dividerPadding: CGFloat = 80.0
        static let sinupRowTopBottomPadding: CGFloat = 15.0
        static let viewXOffset: CGFloat = screen.width + 200.0
        static let viewYOffset: CGFloat = screen.midY - 170.0
        static let textFieldFocusedYOffset: CGFloat = 130.0
    }
    
    var body: some View {
        VStack {
            UserDetailsRow(icon:"person", placeholder: "Full Name", text: $name, textFieldIsFocused: $textFieldIsFocused)
                .padding(.top, Style.sinupRowTopBottomPadding)
            
            Divider().padding(.leading, Style.dividerPadding)
            
            UserDetailsRow(icon:"age", placeholder: "Age", text: $age, textFieldIsFocused: $textFieldIsFocused)

            Divider().padding(.leading, Style.dividerPadding)
            
            UserDetailsRow(icon:"email", placeholder: "Your Email", text: $email, textFieldIsFocused: $textFieldIsFocused)
            
            Divider().padding(.leading, Style.dividerPadding)
            
            UserDetailsRow(icon:"password", placeholder: "Create A Password", text: $password, textFieldIsFocused: $textFieldIsFocused)
                .padding(.bottom, Style.sinupRowTopBottomPadding)
        }
        .frame(maxWidth: screen.width)
        .background(BlurView(style: .prominent))
        .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: Style.shadowRadius, x: 0, y: Style.shadowRadius)
        //.scaleEffect(signupButtonTapped ? 1 : 0.0)
        .offset(y: Style.viewYOffset)
       // .offset(x: signupButtonTapped ? 0.0 : -(Style.viewXOffset))
        .offset(y: textFieldIsFocused ? -Style.textFieldFocusedYOffset : 0.0)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(signupButtonTapped: .constant(true), textFieldIsFocused: .constant(true), email: .constant(""), password: .constant(""), name: .constant(""), age: .constant(""), showAlert: .constant(false), showSuccessAlert: .constant(false), error: .constant(""), loginButtonTapped: .constant(false), successMessage: .constant(""))
    }
}

//MARK:- OnboardingMethodListener
extension SignUpView: OnboardingMethodListener {
    
    func startFlow() {
        let errorMessage = Onboarding.validateField(with: name, age: age, email: email, password: password)
        if errorMessage == nil {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard error == nil else  {
                    self.error = error?.localizedDescription ?? "Something went wrong, error occurred while creating a user. Please Try Again."
                    loginOrSignup(with: .failure(self.error))
                    return
                }
                successMessage = "Signing you in, Hold up."
                loginOrSignup(with: .success(successMessage), result: result)
            }
        } else {
            loginOrSignup(with: .failure(errorMessage ?? ""))
        }
    }
    
    func loginOrSignup(with status: Onboarding.Status, result: AuthDataResult? = nil) {
        
        switch status {
        case .success:
            do {
                let _ = try db.collection("students").addDocument(from: Student(id: result?.user.uid, fullName: name, email: email, password: password, age: age))
                self.showSuccessAlert = true
                self.name = ""
                self.email = ""
                self.password = ""
                self.age = ""
            }
            catch {
                self.showAlert = true
                self.error = "Something went wrong, error occurred while creating a user. Please Try Again."
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showSuccessAlert = false
                self.loginButtonTapped = true
                self.signupButtonTapped = false
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
