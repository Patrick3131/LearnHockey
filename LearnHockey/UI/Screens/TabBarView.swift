//
//  TabBarView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = Tab.exercise
    @Environment(\.injected) private var injected: DIContainer

    
    var body: some View {
        TabView(selection: $selectedTab) {
            CategoriesListView().tabItem {
                TabBarItem(text: "Exercise", image: "star")
            }.tag(Tab.exercise)
            AccountView().tabItem {
                TabBarItem(text: "Account", image: "star")
            }.tag(Tab.profil)
        }
    }
}


extension TabBarView {
    enum Tab: Int {
        case exercise, profil
    }
}
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
