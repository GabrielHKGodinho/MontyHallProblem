//
//  DoorView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 07/02/24.
//

import SwiftUI

struct DoorView: View, Identifiable {
    var id = UUID()
    @State private var isAnimating = false
    @Binding var imageNumber : Int
    
    var imageName : String
    
    var body: some View {
        Image(imageName+"\(imageNumber)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    func startAnimation() {
        isAnimating = true
        
        Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            imageNumber = (imageNumber % 7) + 1
            
            if imageNumber == 7 {
                timer.invalidate()
                self.isAnimating = false
            }
        }
    }
}

//#Preview {
//    DoorView(imageName: "Simulator")
//}
