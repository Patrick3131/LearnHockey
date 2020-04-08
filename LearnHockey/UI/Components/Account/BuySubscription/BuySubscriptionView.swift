//
//  BuySubscriptionView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct BuySubscriptionView: View {
    let viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer().frame(minHeight: 5, idealHeight: 10)
                    VStack(alignment: .center,spacing: 70) {
                        Text("In our subscription all packages and exercises are included. Buy monthly or yearly.").font(.title)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        /// monthly
                        Button(action: {
                            self.viewModel.buyMonthly()
                        }, label: {
                            BuySubscriptionElementView()
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.width * 0.2, alignment: .center)
                        })
                        /// yearly
                        Button(action: {
                            self.viewModel.buyYearly()
                        }, label: {
                            BuySubscriptionElementView(subscriptionText: "Yearly Subscription", amountText: "29.99 € / Year")
                                .frame(width: geometry.size.width * 0.95, height: geometry.size.width * 0.2, alignment: .center)
                        })
                        SubscriptionTestView(testing: {
                            self.viewModel.testing()
                        }, notNow: {
                            self.viewModel.cancelView()
                        }).padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

//struct BuySubscriptionView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuySubscriptionView(viewModel: BuySubscriptionView.ViewModel(container: DIContainer.defaultValue.self))
//    }
//}
