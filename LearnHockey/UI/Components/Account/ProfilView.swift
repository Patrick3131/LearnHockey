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
                    ProfilOverviewView(viewModel: self.viewModel.createProfilOverViewViewModel())
                    FeedbackView(action: {
                        self.viewModel.sendFeedback()
                    })
                    Spacer().frame(height: 50)
                    Button(action: {
                        self.viewModel.deleteProfil()
                    }, label: {
                        Text("I want to delete my profil").foregroundColor(.black)
                    })
                    Spacer().frame(height: 15)
                }.frame(width: geometry.size.width, alignment: .center)
                    .frame(minHeight: 750)
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
        
        
    }
}


extension ProfilView {
    struct ViewModel {
        var sendFeedback: () -> Void
        var deleteProfil: () -> Void
        func createProfilOverViewViewModel() -> ProfilOverviewView.ViewModel {
            return ProfilOverviewView.ViewModel(managed: {
                
            })
        }
        
    }
    
    
    
}


struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilView(viewModel: ProfilView.ViewModel(sendFeedback: {
            
        }, deleteProfil: {
            
        }))
    }
}
