//
//  AccountLoggedIn.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 03.03.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct AccountLoggedIn: View {
    var userName: String
    var logOut: () -> Void
    var buyPremium: () -> Void
    var isPremium: Bool
    
    private let premiumText: String = "You currently have a monthly membership for 2.99 € / month."
    private let nonPremiumText: String = "In our subscription all packages and exercises are included. Buy monthly or yearly."
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello " + self.userName + "!" ).font(.title)
                Spacer().frame(height: geometry.size.height * 0.1)
                self.premiumTextView()
                    .frame(width: geometry.size.width * 0.6)
                Spacer().frame(height: geometry.size.height * 0.1)
                Group {
                    if !self.isPremium {
                        VStack(alignment: .center,spacing: 70) {
                            Button(action: {
                                self.buyPremium()
                            }, label: {
                                BuySubscriptionElementView()
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                            })
                            Button(action: {
                                self.buyPremium()
                            }, label: {
                                BuySubscriptionElementView(subscriptionText: "Yearly Subscription", amountText: "29.99 € / Year")
                                .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.2, alignment: .center)
                            })
                        }
                        
                    } else {
                        EmptyView()
                    }
                }
                Spacer().frame(height: geometry.size.height * 0.1)
                ActionButton(action: {
                    self.logOut()
                }, title: "Log out", width: geometry.size.width * 0.7)
            }
        }
    }
    
    private func premiumTextView() -> some View {
        Text(isPremium ? premiumText : nonPremiumText)
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding()
    }
    
    private func premiumView() -> some View {
        GeometryReader { geometry in
            Group {
                if !self.isPremium {
                    VStack(alignment: .center) {
                        Button(action: {
                            self.buyPremium()
                        }, label: {
                            BuySubscriptionElementView()

                        })
//                            .frame(width:200)
                        Button(action: {
                            self.buyPremium()
                        }, label: {
                            BuySubscriptionElementView(subscriptionText: "Yearly Subscription", amountText: "29.99 € / Year")

                        })
                    }
                    
                } else {
                    EmptyView()
                }
            }
        }
        
    }
}

struct AccountLoggedIn_Previews: PreviewProvider {
    static var previews: some View {
        AccountLoggedIn(userName: "User", logOut: {
            
        }, buyPremium: {
            
        }, isPremium: false)
    }
}
