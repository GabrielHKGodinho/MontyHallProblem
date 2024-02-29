//
//  MenuView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 01/02/24.
//

import SwiftUI

struct MenuView: View {
    let soundManager = SoundManager()
    var playSong : Bool
    @State private var imageNumberPlayGame = 1
    @State private var imageNumberParadox = 1
    @State private var imageNumberSimulator = 1
    @State private var imageNameDoor1 = "doorPlayGame"
    @State private var imageNameDoor2 = "Paradox"
    @State private var imageNameDoor3 = "Simulator"
    @State private var zoom: Int? = nil
    @State private var fadeout: Int? = nil
    @State private var updown = false
    @State private var start = true
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    
    var body: some View {
        NavigationStack{
            VStack {
                Image("menuSign")
                    .resizable()
                    .frame(width: 800)
                    .offset(y: updown ? -60 : (start ? -700 : -30))
                    .onAppear {
                        start = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(Animation.linear(duration: 0.5)) {
                                self.start = false
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                                self.updown.toggle()
                            }
                        }
                    }
                HStack(spacing: 50) {
                    ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                        Button {
                            if index == 0 {
                                soundManager.stop(sound: .backgroundMenu)
                                soundManager.isPlayingMainSong = false
                            }
                            
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
                        }
                    }
                }
                .padding(.leading, 70)
                .padding(.bottom, 50)
                .padding(.leading, zoom == nil ? 50 : (zoom == 0 ? 4000 : 1000))
                
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        if playSong {
                            soundManager.playLoop(sound: .backgroundMenu)
                        }
                    }
                    imageNumberPlayGame = 1
                    imageNumberParadox = 1
                    imageNumberSimulator = 1
                    zoom = nil
                    fadeout = nil
                    doorList = []
                    doorList.append(DoorView(imageNumber: $imageNumberPlayGame, imageName: $imageNameDoor1))
                    doorList.append(DoorView(imageNumber: $imageNumberParadox, imageName: $imageNameDoor2))
                    doorList.append(DoorView(imageNumber: $imageNumberSimulator, imageName: $imageNameDoor3))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("menuEmpty")
                    .resizable()
            )
            .ignoresSafeArea()
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isNavigationActive) {
                switch zoom {
                case 0 :
                    StaticTVView()
                case 1:
                    LearnView1()
                default:
                    SimulatorView()
                }
            }
        }
    }
    
}


#Preview {
    MenuView(playSong: true)
}
