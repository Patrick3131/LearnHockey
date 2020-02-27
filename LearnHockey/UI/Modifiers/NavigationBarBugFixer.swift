//
//  NavigationBarBugFixer.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 27.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

// MARK: - A workaround for a bug in NavigationBar
// https://stackoverflow.com/q/58404725/2923345

private struct NavigationBarBugFixer: ViewModifier {
        
    let goBack: () -> Void
    
    func body(content: Content) -> some View {
        #if targetEnvironment(simulator)
        let isiPhoneSimulator = UIDevice.current.userInterfaceIdiom == .phone
        return Group {
            if ProcessInfo.processInfo.isRunningTests {
                content
            } else {
                content
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: Button(action: {
                        print("Please note that NavigationView currently does not work correctly on the iOS Simulator.")
                        self.goBack()
                    }, label: { Text(isiPhoneSimulator ? "Back" : "") }))
            }
        }
        #else
        return content
        #endif
    }
}

extension View {
    func fixNavigationBarBug(goBack: @escaping () -> Void) -> some View {
        return modifier(NavigationBarBugFixer(goBack: goBack))
    }
}
