//
//  StaticTVView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 13/02/24.
//

import SwiftUI

struct StaticTVView: View {
    @State private var isNavigationActive: Bool = false
    @State private var imageNumber = 1
    
    @State var transitionOpacity = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("static-\(imageNumber)")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
                    .opacity(transitionOpacity ? 0 : 1)
            }
            .background(.black)
            .navigationBarBackButtonHidden()
            .onAppear{
                Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
                    imageNumber = (imageNumber % 6) + 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    self.isNavigationActive = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.transitionOpacity = false
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigationActive) {
                AudienceView()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    StaticTVView()
}
