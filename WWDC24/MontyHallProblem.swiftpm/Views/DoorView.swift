//
//  DoorView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 07/02/24.
//

import SwiftUI

struct DoorView: View, Identifiable {
    var id = UUID()
    @Binding var imageNumber : Int
    @Binding var imageName : String
    
    var body: some View {
        Image(imageNumber >= 5 ? "doorPlayGame"+"\(imageNumber)" : imageName+"\(imageNumber)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            imageNumber = (imageNumber % 7) + 1
            
            if imageNumber == 7 {
                timer.invalidate()
            }
        }
    }
    
    func startFlashing() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if imageNumber != 1 {
                timer.invalidate()
            } else {
                let ligth = imageName.contains("ligth") ? "dark" : "ligth"
                
                let index = imageName.index(imageName.startIndex, offsetBy: 4)
                let glow = imageName.contains("glow") ? "glow" : ""
                switch imageName[index]{
                case "1":
                    imageName = "door1"+ligth+glow
                case "2":
                    imageName = "door2"+ligth+glow
                case "3":
                    imageName = "door3"+ligth+glow
                default:
                    fatalError("Porta desconhecida")
                }
            }
            
        }
    }
    
    func correctName() {
        if imageName.contains("dark") {
            let index = imageName.index(imageName.startIndex, offsetBy: 4)
            imageName = "door\(imageName[index])ligth"
        }
    }
}

#Preview {
    DoorView(imageNumber: .constant(1), imageName: .constant("door1ligth"))
}
