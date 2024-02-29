//
//  LearnView3.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

// ?
struct LearnView3: View {
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 7
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligthglow"
    @State private var imageNameDoor3 = "doorPlayGame"
    @State private var reveal = false
    @State private var revealNo = false
    @State private var reveal50 = true
    @State private var updown = false
    
    let texts = [
        "NO!",
        "Actually, the chance of winning by SWITCHING doors is higher, 66%, or 2/3.",
        "Want to understand why? Choose one of the two explanations."
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
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(Animation.easeOut(duration: 0.2)) {
                                self.revealNo.toggle()
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
                            
                            if textPosition != 2 {
                                Spacer()
                                
                                Image(systemName: "arrowtriangle.down.fill")
                                    .bold()
                                    .font(.system(size: 40))
                                    .offset(y: updown ? 10 : -10)
                            }
                        }
                        .frame(width: 900)
                    }
                    .onTapGesture {
                        if textPosition == 1 {
                            isNavigationActive = true
                        } else if textPosition == 0 {
                            revealNo = false
                            withAnimation(.easeInOut(duration: 1)) {
                                self.reveal50 = false
                            }
                            textPosition += 1
                        } else {
                            textPosition += 1
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
                
                HStack(spacing: 90) {
                    ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                        ZStack {
                            Image(reveal50 ? "50%" : (index == 0 ? "66%" : "33%"))
                                .resizable()
                                .frame(width: 230, height: 230)
                                .padding(.trailing, 90)
                                .padding(.bottom, 100)
                                .opacity((index == 0 || index == 1) ? 1 : 0)
                        }
                        
                    }
                }
                .padding(.leading, 100)
                .padding(.bottom, 90)
                
                Image("no")
                    .resizable()
                    .frame(width: 730, height: 430)
                    .offset(y: revealNo ? -70 : -900)
                
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                ChooseView()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    LearnView3()
}
