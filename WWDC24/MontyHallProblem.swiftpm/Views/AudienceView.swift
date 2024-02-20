//
//  AudienceView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 13/02/24.
//

import SwiftUI

struct AudienceView: View {
    @State private var isNavigationActive: Bool = false
    @State private var imageNumber = 1
    @State private var appear = false
    let texts = [
        "Hello! I'm Monty Hall",
        "And you're watching LET'S MAKE A DEAL!"
    ]
    @State var textPosition = 0
    var body: some View {
        NavigationStack {
            ZStack {
                Image("audience\(imageNumber)")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
                
                Image("montyFullBody")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 800)
                    .padding(.top, 50)
                
                ZStack {
                    Image("textNormal")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 170)
                    
                    Text(texts[textPosition])
                        .bold()
                        .font(.system(size: 32))
                }
                .padding(.top, 550)
                .opacity(appear ? 1 : 0)
                .onTapGesture {
                    if textPosition == 1 {
                        isNavigationActive = true
                    } else {
                        textPosition += 1
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden()
            .onAppear{
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                    imageNumber = (imageNumber % 4) + 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.appear = true
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigationActive) {
                GameView()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    AudienceView()
}
