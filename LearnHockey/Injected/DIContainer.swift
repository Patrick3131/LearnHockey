//
//  DIContainer.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 17.02.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI
import Combine


struct DIContainer: EnvironmentKey {
    let appState: Store<AppState>
    let interactors: Interactors
    
    static var defaultValue: Self { Self.default}
    private static let `default` = Self(appState: .init(AppState()), interactors: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self]}
        set { self[DIContainer.self] = newValue }
    }
}

extension View {
    func inject(_ appState: AppState, _ interactors: DIContainer.Interactors) -> some View {
        let container = DIContainer(appState: .init(appState), interactors: interactors)
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
        .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}
