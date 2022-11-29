//
//  OnBoardingView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 28/09/20.
//

import SwiftUI
import Firebase
import FirebaseAuth

protocol OnboardingMethodListener {
    func startFlow()
    func loginOrSignup(with status: Onboarding.Status, result: AuthDataResult?)
}

struct OnBoardingView: View {
    @State var loginButtonTapped: Bool = false
    @State var signupButtonTapped: Bool = false
    @State var textFieldIsFocused: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var age: String = ""
    @State var skipButtonTapped: Bool = false
    @State var showDashboard: Bool = false
    @EnvironmentObject var user: User

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                MainView(loginButtonTapped: $loginButtonTapped,
                         signupButtonTapped: $signupButtonTapped,
                         email: $email,
                         password: $password,
                         name: $name,
                         age: $age,
                         textFieldIsFocused: $textFieldIsFocused,
                         skipButtonTapped: $skipButtonTapped,
                         showDashboard: $showDashboard)
                
                if skipButtonTapped {
                    BannerView(title: "Flewing you to the dashboard, Hold on Steady!!", image: "rocket")
                }
                
                if self.user.userSkippedLogin {
                    AppTabView(viewModel: TabBarViewModel())
                }
                
                if self.user.userLoggedIn {
                    AppTabView(viewModel: TabBarViewModel())
                }
            }
            .navigationBarHidden(true)
        }
        .statusBar(hidden: true)
    }
}

struct MainView: View {
    @Binding var loginButtonTapped: Bool
    @Binding var signupButtonTapped: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var age: String
    @Binding var textFieldIsFocused: Bool
    @Binding var skipButtonTapped: Bool
    @Binding var showDashboard: Bool
    @State var showAlert: Bool = false
    @State var showSuccessAlert: Bool = false
    @State var error: String = ""
    @EnvironmentObject var user: User
    @State var successMessage: String = ""
    
    private let db = Firestore.firestore()
     
    var body: some View {
        ZStack(alignment: .top) {
            
            Colors.Palette.indigoDye.color
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                .edgesIgnoringSafeArea(.bottom)
                .onTapGesture {
                    self.textFieldIsFocused = false
                    GlobalFunctions.hideKeyboard()
                }
            
            WelcomeCardView(loginButtonTapped: $loginButtonTapped, signupButtonTapped: $signupButtonTapped)
            
            VStack {
                Spacer()
                VStack(spacing: 15.0) {
                    Button(action: {
                        self.showSignupPage()
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(Colors.Palette.indigoDye.color)
                    }
                    .frame(width: 150, height: 54, alignment: .center)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 27.0, style: .continuous))
                    .shadow(color: Color.white.opacity(0.4), radius: 40, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
                    .opacity(textFieldIsFocused ? 0 : 1.0)
                    .opacity(signupButtonTapped || loginButtonTapped ? 0.0 : 1.0)
                    
                    if signupButtonTapped || loginButtonTapped {
                        Text(signupButtonTapped ? "By clicking on Signup, you will be agreeing to the Terms and Conditions" : loginButtonTapped ? "Please enter login credentials to continue" : "")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    if !(signupButtonTapped && !loginButtonTapped){
                        HStack {
                            Text("Already a subscriber?")
                                .font(.system(size: 18, weight: .light))
                            Text("Login")
                                .font(.system(size: 18, weight: .bold))
                                .onTapGesture {
                                    self.showLoginPage()
                                }
                        }
                        .foregroundColor(.white)
                        .opacity(loginButtonTapped || signupButtonTapped ? 0.0 : 1.0)
                    }
                    
                    Button(action: {
                        self.skipButtonTapped = true
                        self.skip()
                    }) {
                        Text("Skip")
                            .font(.headline)
                            .foregroundColor(Color.white)
                    }
                    .opacity(signupButtonTapped || loginButtonTapped ? 0.0 : 1.0)
                }
            }
            .padding()
            
            let loginView: LoginView = LoginView(loginButtonTapped: $loginButtonTapped, textFieldIsFocused: $textFieldIsFocused, email: $email, password: $password, error: $error, showAlert: $showAlert, showSuccessAlert: $showSuccessAlert, successMessage: $successMessage)
                    
            
            let signupView: SignUpView = SignUpView(signupButtonTapped: $signupButtonTapped, textFieldIsFocused: $textFieldIsFocused, email: $email, password: $password, name: $name, age: $age, showAlert: $showAlert, showSuccessAlert: $showSuccessAlert, error: $error, loginButtonTapped: $loginButtonTapped, successMessage: $successMessage)
            
            loginView

            signupView
            
            HStack {
                Spacer()
                HStack {
                    if textFieldIsFocused {
                        Button(action: {
                            if signupButtonTapped {
                                signupView.startFlow()
                            }
                            if loginButtonTapped {
                                loginView.startFlow()
                            }
                        }) {
                            Text(loginButtonTapped ? "Login" : "Sign Up")
                                .font(.headline)
                                .foregroundColor(Colors.Palette.indigoDye.color)
                        }
                        .animation(.easeInOut)
                    }
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Colors.Palette.indigoDye.color)
                        .animation(.easeInOut)
                        .onTapGesture {
                            self.cancelButtonTapped()
                        }
                }
                .frame(width: textFieldIsFocused ? 150 : 54, height: 54)
                .background(Color.white)
                .opacity(loginButtonTapped || signupButtonTapped ? 1.0 : 0.0)
                .clipShape(RoundedRectangle(cornerRadius: 27, style: .continuous))
                .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0.0, y: 20.0)
                .animation(.easeInOut)
            }
            .padding()
            
        }
    }
}

struct WelcomeCardView: View {
    @Binding var loginButtonTapped: Bool
    @Binding var signupButtonTapped: Bool
    
    private struct Style {
        static let subTextLineLimit: Int = 3
        static let subTextHeight: CGFloat = 80.0
        static let lottieAnimationWidth: CGFloat = 150.0
        static let cloudsYOffset: CGFloat = 50
        static let cornerRadius: CGFloat = 25.0
        static let shadowRadius: CGFloat = 30.0
        static let shadowYOffset: CGFloat = 20.0
    }
    
    var body: some View {
        VStack {
            Text("Welcome to EduCloud")
                .font(.title)
                .bold()
            
            Text("Give your child the insights for becoming whatever they aspire to be")
                .multilineTextAlignment(.center)
                .lineLimit(Style.subTextLineLimit)
                .frame(height: Style.subTextHeight)
            
            LottieView(filename: "clouds")
                .frame(width: Style.lottieAnimationWidth, height: screen.height/5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .scaleEffect(2.0)
                .offset(y: -Style.cloudsYOffset)
            
            LottieView(filename: "reading")
                .frame(width: Style.lottieAnimationWidth, height: screen.height/5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .scaleEffect(1.8)
            
        }
        .padding()
        .opacity(loginButtonTapped || signupButtonTapped ? 0.0 : 1.0)
        .frame(width: screen.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(BlurView(style: .systemThinMaterial))
        .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
        .scaleEffect(loginButtonTapped || signupButtonTapped ? 0 : 1.0)
        .offset(x: loginButtonTapped ? -screen.width : 0.0)
        .offset(x: signupButtonTapped ? screen.width : 0.0)
        .shadow(color: Color.black.opacity(0.2), radius: Style.shadowRadius, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: Style.shadowYOffset)
        .animation(.spring(response: 0.70, dampingFraction: 0.8, blendDuration: 0.0))
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
       OnBoardingView()
        .environmentObject(User())
    }
}

//MARK:- Private Helpers
private extension MainView {
    func showLoginPage() {
        self.loginButtonTapped = true
    }
    
    func skip() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.skipButtonTapped = false
            self.user.userSkippedLogin = true
        }
    }
    
    func showSignupPage() {
        self.signupButtonTapped = true
    }
    
    func cancelButtonTapped() {
        self.name = ""
        self.email = ""
        self.password = ""
        self.age = ""
        self.loginButtonTapped = false
        self.signupButtonTapped = false
        self.textFieldIsFocused = false
        GlobalFunctions.hideKeyboard()
    }
}
