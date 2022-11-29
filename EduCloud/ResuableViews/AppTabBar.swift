//
//  AppTabBar.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 19/09/20.
//

import SwiftUI

struct AppTabBar: View {
    @Binding var selectedIndex: Int
    @Binding var selectedTab: TabBarViewModel.TabBar
    var viewModel: TabBarViewModel
    var subject: Subject.Subjects
    
    struct Style {
        static let tabBarWidth: CGFloat = 230.0
        static let tabBarHeight: CGFloat = 54.0
        static let tabBarCornerRadius: CGFloat = 27.0
        static let tabBarBottomPadding: CGFloat = 16.0
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 30) {
                ForEach(viewModel.whiteListTabs, id: \.self) { tab in
                    TabBarButton(buttonImage: tab.image.unselected, index: tab.rawValue, tab: tab, selectedIndex: self.$selectedIndex, subject: subject)
                }
            }
            .frame(width: Style.tabBarWidth, height: Style.tabBarHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.white)
            .cornerRadius(Style.tabBarCornerRadius)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 10.0)
            .padding()
            .padding(.bottom, Style.tabBarBottomPadding)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TabBarButton: View {
    var buttonImage: Image
    var index: Int = 0
    var tab: TabBarViewModel.TabBar
    @Binding var selectedIndex: Int
    var subject: Subject.Subjects
    
    struct Style {
        static let buttonSize: CGSize = CGSize(width: 24.0, height: 24.0)
    }
    
    var body: some View {
        
        Button(action: {
            selectedIndex = index
        }) {
            if selectedIndex == index {
                tab.image.selected
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(subject.color)
                    .frame(width: Style.buttonSize.width, height: Style.buttonSize.height, alignment: .center)
                    .font(.system(size: Style.buttonSize.width, weight: .bold, design: .rounded))
            } else {
                buttonImage
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(subject.color)
                    .frame(width: Style.buttonSize.width, height: Style.buttonSize.height, alignment: .center)
                    .font(.system(size: Style.buttonSize.width, weight: .regular, design: .rounded))
            }
        }
    }
}

struct AppTabBar_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBar(selectedIndex: .constant(0), selectedTab: .constant(.home), viewModel: TabBarViewModel(), subject: .maths)
    }
}

