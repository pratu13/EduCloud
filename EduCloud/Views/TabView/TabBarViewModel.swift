//
//  TabBarViewModel.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 10/09/20.
//  Copyright © 2020 Pratyush Duklan. All rights reserved.
//

import Foundation
import SwiftUI

final class TabBarViewModel: ObservableObject {
    
    enum TabBar: Int, CaseIterable, Equatable {
        case home = 0
        case study
        case notification
        case search
        
        var image: (selected: Image, unselected: Image) {
            switch self {
            case .home:
                return (Image(systemName: "house.fill"), Image(systemName: "house"))
            case .study:
                return (Image(systemName: "book.fill"), Image(systemName: "book"))
            case .notification:
                return (Image(systemName: "bell.fill"),Image(systemName: "bell"))
            case .search:
                return (Image(systemName: "magnifyingglass"),
                        Image(systemName: "magnifyingglass"))
            }
        }
    }
    
    let whiteListTabs: [TabBarViewModel.TabBar]
    
    init() {
        whiteListTabs = TabBarViewModel.getWhiteListTabs()
    }
    
}

private extension TabBarViewModel {
    static func getWhiteListTabs() -> [TabBarViewModel.TabBar]{
        return  [.home, .study, .notification, .search]
    }
}
