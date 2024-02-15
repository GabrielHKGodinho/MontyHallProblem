//
//  MenuView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 01/02/24.
//

import SwiftUI

struct MenuView: View {
    @State private var imageNumberPlayGame = 1
    @State private var imageNumberParadox = 1
    @State private var imageNumberSimulator = 1
    @State private var zoom: Int? = nil
    @State private var fadeout: Int? = nil
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    
    var body: some View {
        NavigationStack{
            HStack {
                ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                    Button {
                        door.startAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeIn(duration: 1)) {
                                self.zoom = index
                            }
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.fadeout = index
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            self.isNavigationActive = true
                        }
                    } label:{
                        door
                            .opacity((fadeout == index || fadeout == nil) ? 1 : 0)
                            .scaleEffect(zoom == index ? 20 : 1)
                    }
                }
            }
            .onAppear{
                imageNumberPlayGame = 1
                imageNumberParadox = 1
                imageNumberSimulator = 1
                zoom = nil
                fadeout = nil
                doorList = []
                doorList.append(DoorView(imageNumber: $imageNumberPlayGame, imageName: "doorPlayGame"))
                doorList.append(DoorView(imageNumber: $imageNumberParadox, imageName: "Paradox"))
                doorList.append(DoorView(imageNumber: $imageNumberSimulator, imageName: "Simulator"))
            }
            
            .navigationDestination(isPresented: $isNavigationActive) {
                switch zoom {
                case 0 :
                    StaticTVView()
                case 1:
                    SimulatorView()
                default:
                    SimulatorView()
                }
            }
        }
    }
    
}


#Preview {
    MenuView()
}
