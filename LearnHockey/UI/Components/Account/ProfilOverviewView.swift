//
//  ProfilView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ProfilOverviewView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(systemName: "person.circle")
                    .font(.system(size: 200))
                Spacer().frame(width: 50, height: 50, alignment: .center)
                Text("Patrick").font(.largeTitle)
                Spacer().frame(width: 50, height: 30, alignment: .center)
                SubscriptionView(subscription: SubscriptionView.Subscription.validSubscription(period: .monthly, cost: "13€", valid: .renew("15. Mai")))
                Spacer().frame(width: 50, height: 30, alignment: .center)
                ActionButton(action: {
                    
                }, title: "Manage", width: 150)
                
            }
            
        }
    }
}

struct ProfilOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilOverviewView()
    }
}
