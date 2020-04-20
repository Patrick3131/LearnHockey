//
//  TabBarView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
//        let newAppearance = UINavigationBarAppearance()
//        newAppearance.configureWithOpaqueBackground()
//        newAppearance.backgroundColor = UIColor(named: "baseMidDark")
//        newAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        UINavigationBar.appearance().backgroundColor = UIColor(named: "baseMidDark")
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemBackground]
        UITabBar.appearance().barTintColor = UIColor(named: "baseMidDark")
    }
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            CategoriesListView(viewModel: self.viewModel.createCategoriesListViewModel()).tabItem {
                TabBarItem(text: "Exercise", image: "star")
            }.tag(Tab.exercise)
            AccountView(viewModel: self.viewModel.createAccountViewModel()).tabItem {
                TabBarItem(text: "Account", image: "person")
            }.tag(Tab.profil)
        }.accentColor(Color(.systemBackground))
    }
}


extension TabBarView {
    enum Tab: Int {
        case exercise, profil
    }
}
//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
