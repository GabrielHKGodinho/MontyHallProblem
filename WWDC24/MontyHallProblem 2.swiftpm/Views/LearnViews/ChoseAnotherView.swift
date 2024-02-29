//
//  ChoseAnotherView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 24/02/24.
//

import SwiftUI

struct ChoseAnotherView: View {
    var cameFromTryToMiss : Bool
    
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNameDoor1 = "TryToMiss"
    @State private var imageNameDoor2 = "Menu"
    @State private var zoom: Int? = nil
    @State private var fadeout: Int? = nil
    
    let texts = [
        "Not convinced yet? Consider the other explanation."
    ]
    @State var textPosition = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack{
                        HStack(spacing: 90) {
                            ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                                Button {
                                    door.startAnimation()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn(duration: 0.9)) {
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
                                        .frame(width: 300)
                                        .opacity((fadeout == index || fadeout == nil) ? 1 : 0)
                                        .scaleEffect(zoom == index ? 20 : 1)
                                        .offset(x: zoom == nil ? 0 : 1000)
                                }
                                
                            }
                        }
                        .padding(.leading, 100)
                        .padding(.bottom, 90)
                    }
                    .onAppear{
                        doorList = []
                        imageNameDoor1 = cameFromTryToMiss ? "MoreDoors" : "TryToMiss"
                        doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoor1))
                        doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoor2))
                        
                    }
                    ZStack {
                        Image("textNormal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 170)
                            .shadow(radius: 4, x: 12, y: 12)
                        
                        HStack {
                            Text(texts[textPosition])
                                .bold()
                                .font(.system(size: 32))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 900)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(){
                    Image("stage")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fill)
                }
                
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                switch zoom {
                case 0 :
                    if cameFromTryToMiss {
                        MoreDoorsView(goToMenu: true)
                    } else {
                        TryToMiss1(goToMenu: true)
                    }
                case 1:
                    MenuView(playSong: false)
                default:
                    SimulatorView()
                }
            }
        }
    }
}

#Preview {
    ChoseAnotherView(cameFromTryToMiss: true)
}
