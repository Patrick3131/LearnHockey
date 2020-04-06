//
//  BuySubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct BuySubscriptionView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center,spacing: 70) {
                Text("In our subscription all packages and exercises are included. Buy monthly or yearly.").font(.title)
                Button(action: {
//                    self.buyPremium()
                }, label: {
                    BuySubscriptionElementView()
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                })
                Button(action: {
//                    self.buyPremium()
                }, label: {
                    BuySubscriptionElementView(subscriptionText: "Yearly Subscription", amountText: "29.99 € / Year")
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                })
                SubscriptionTestView(testing: {
                    
                }, cancel: {
                    
                })
            }
            
        }
    }
}

struct BuySubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        BuySubscriptionView()
    }
}
