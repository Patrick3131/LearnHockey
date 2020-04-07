//
//  ProfilView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ProfilOverviewView: View {
//    var manage: () -> Void?
    var viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(systemName: "person.circle")
                    .font(.system(size: 200))
                Spacer().frame(width: 50, height: 50, alignment: .center)
                Text(self.viewModel.name).font(.largeTitle)
                Spacer().frame(width: 50, height: 30, alignment: .center)
                SubscriptionView(subscription: self.viewModel.subscription)
                Spacer().frame(width: 50, height: 30, alignment: .center)
                ActionButton(action: {
                    self.viewModel.manage()
                }, title: "Manage", width: 150)
                
            }
            
        }
    }
}

extension ProfilOverviewView {
    struct ViewModel {
        var name: String
        var subscription: SubscriptionView.Subscription
        var manage: () -> Void
    }
}

struct ProfilOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilOverviewView(viewModel: ProfilOverviewView.ViewModel(name: "Thomas", subscription: .validSubscription(period: .monthly, cost: "14€", valid: .expired("15. Mai")), manage: {
            
        }))
    }
}
