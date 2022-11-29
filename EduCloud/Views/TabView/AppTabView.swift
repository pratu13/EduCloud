//
//  AppTabView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 20/09/20.
//

import SwiftUI
import UIKit

let profile_Image: Image = Image("profile_temp")

struct AppTabView: View {
    @State var selectedIndex: Int = 0
    @State var selectedTab: TabBarViewModel.TabBar = .home
    @State var menuButtonTapped: Bool = false
    var tab: TabBarViewModel.TabBar = .home
    @State var signOutButtonTapped: Bool = false
    @EnvironmentObject var user: User
    var viewModel: TabBarViewModel
    
    var body: some View {
        ZStack {
            MenuView(menuButtonTapped: $menuButtonTapped, signOutButtonTapped: $signOutButtonTapped, profile: "person_profile",color: user.chosenSubject.color)
            
            ZStack {
                Color.white
                    .cornerRadius(menuButtonTapped ? 30.0 : 0.0)
                
                TabView(selection: $selectedIndex) {
                    
                    ForEach(viewModel.whiteListTabs, id: \.self) { tab in
                        switch(tab) {
                        case .home:
                            HomeView()
                                .tag(0)
                        case .study:
                            StudyView()
                                .tag(1)
                        case .notification:
                            NotificationView()
                                .tag(2)
                        case .search:
                            SearchView()
                                .tag(3)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .edgesIgnoringSafeArea(.all)
                
                AppTabBar(selectedIndex: $selectedIndex, selectedTab: $selectedTab, viewModel: viewModel, subject: user.chosenSubject)
                
                HeaderView(menuButtonTapped: $menuButtonTapped,profile: "person_profile")
                
            }
            .blur(radius: menuButtonTapped ? 1.0 : 0.0)
            .rotation3DEffect(Angle(degrees: menuButtonTapped ? -25.0: 0.0), axis: (x: 1.0, y: 1.0, z: 1.0))
            .offset(x: menuButtonTapped ? 180 : 0.0)
            .animation(.easeInOut)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .disabled(menuButtonTapped)
            
            SignOutConfirmationView(signOutButtonTapped: $signOutButtonTapped)
                .offset(y: signOutButtonTapped ? 0.0 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .statusBar(hidden: true)
    }

}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(viewModel: TabBarViewModel())
    }
}



