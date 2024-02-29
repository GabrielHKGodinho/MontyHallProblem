//
//  LearnView2.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

// ?
struct LearnView2: View {
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligthglow"
    @State private var imageNameDoor3 = "door3ligth"
    @State private var reveal = false
    @State private var revealMonty = false
    @State private var reveal50 = false
    @State private var updown = false
    
    let texts = [
        "Well, first you choose a door, let's say, door number 2.",
        "Then, the host will open a door that he knows doesn't have the prize.",
        "And will ask if you want to switch doors or stay with the one you chose.",
        "So, the chance of the prize being behind each of the doors is 50%, right?"
    ]
    @State var textPosition = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    VStack{
                        HStack(spacing: 90) {
                            ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                                ZStack {
                                    door
                                        .frame(width: 300)
                                    
                                    if index == 2 {
                                        Image("Pair of Torn Socks")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .padding(.trailing, 130)
                                            .padding(.top, 100)
                                            .opacity(reveal ? 1 : 0)
                                    }
                                }
                                
                            }
                        }
                        .padding(.leading, 100)
                        .padding(.bottom, 90)
                    }
                    .onAppear{
                        doorList = []
                        doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoor1))
                        doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoor2))
                        doorList.append(DoorView(imageNumber: $imageNumberDoor3, imageName: $imageNameDoor3))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                self.updown.toggle()
                            }
                        }
                        for doorView in doorList {
                            doorView.startFlashing()
                        }
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
                            
                            Spacer()
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .bold()
                                .font(.system(size: 40))
                                .offset(y: updown ? 10 : -10)
                        }
                        .frame(width: 900)
                    }
                    .onTapGesture {
                        if textPosition == 3 {
                            isNavigationActive = true
                        } else if textPosition == 0 {
                            textPosition += 1
                            doorList[2].startAnimation()
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.reveal = true
                            }
                        } else if textPosition == 1 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealMonty = true
                            }
                        } else {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealMonty = false
                                self.reveal50 = true
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(){
                    Image("stage")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fill)
                }
                HStack {
                    Image("montyAsk")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 800)
                        .rotationEffect(Angle(degrees: 80))
                        .offset(!revealMonty ? CGSize(width: -1000.0, height: -100.0) : CGSize(width: 10.0, height: -100.0))
                    
                    Spacer()
                }
                
                HStack(spacing: 90) {
                    ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                        ZStack {
                            Image("50%")
                                .resizable()
                                .frame(width: 230, height: 230)
                                .padding(.trailing, 90)
                                .padding(.bottom, 100)
                                .opacity(((index == 0 || index == 1)  && reveal50) ? 1 : 0)
                        }
                        
                    }
                }
                .padding(.leading, 100)
                .padding(.bottom, 90)
                
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                LearnView3()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LearnView2()
}
