//
//  AudienceView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 13/02/24.
//

import SwiftUI

struct AudienceView: View {
    @State private var imageNumber = 1
    var body: some View {
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
            
            Image("textNormal")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 170)
                .padding(.top, 550)
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                imageNumber = (imageNumber % 4) + 1
            }
        }
    }
}

#Preview {
    AudienceView()
}
