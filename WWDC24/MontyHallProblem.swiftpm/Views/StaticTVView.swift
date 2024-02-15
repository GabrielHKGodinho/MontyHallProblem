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
    var body: some View {
        NavigationStack {
            VStack {
                Image("static-\(imageNumber)")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
            }
            .navigationBarBackButtonHidden()
            .onAppear{
                Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
                    imageNumber = (imageNumber % 6) + 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    self.isNavigationActive = true
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
