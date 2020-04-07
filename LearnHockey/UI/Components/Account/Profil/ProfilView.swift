//
//  ProfilView.swift
//  LearnHockey
//
//  Created by Patrick Fischer on 06.04.20.
//  Copyright © 2020 Patrick Fischer. All rights reserved.
//

import SwiftUI

struct ProfilView: View {
    let viewModel: ViewModel
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Spacer().frame(height:20)
                    ProfilOverviewView(viewModel: self.viewModel.profilOverviewViewModel)
                    Spacer().frame(height: 20)
                    FeedbackView(action: {
                        self.viewModel.sendFeedback()
                    })
                    Spacer().frame(height: 30)
                    Button(action: {
                        self.viewModel.deleteProfil()
                    }, label: {
                        Text("I want to delete my profil").foregroundColor(.black)
                    })
                    Spacer().frame(height: 15)
                }.frame(width: geometry.size.width, alignment: .center)
                    .frame(minHeight: 650)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}


extension ProfilView {
    struct ViewModel {
        let profilOverviewViewModel: ProfilOverviewView.ViewModel
        var sendFeedback: () -> Void
        var deleteProfil: () -> Void
    }
}


struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(viewModel: ProfilView.ViewModel(profilOverviewViewModel: ProfilOverviewView.ViewModel(name: "Thomas", subscription: .noSubscription(valid: .neverSubscribed), manage: {
            
        }), sendFeedback: {
            
        }, deleteProfil: {
            
        }))
    }
}
