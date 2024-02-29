//
//  TryToMiss1.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

// ?
struct TryToMiss1: View {
    var goToMenu: Bool
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligth"
    @State private var imageNameDoor3 = "door3ligth"
    @State private var updown = false
    @State private var revealItem1 = false
    @State private var revealItem2 = false
    @State private var revealItem3 = false
    @State private var revealStar = false
    @State private var revealX = false
    @State private var revealMonty = false
    @State private var rotation: Double = 0.0
    @State private var scalex = false
    @State private var reveal50 = false
    
    let texts = [
        "Imagine you went to the show convinced that you would switch doors when asked.",
        "What would happen if you chose the right door on the first attempt?",
        "You, when asked, would switch doors and would not win the prize.",
        "So your goal on the first choice is to pick one of the two doors that does not have the prize.",
        "And regardless of which one you choose, the host will open the other one that is empty.",
        "So when asked if you want to switch, you will do it.",
        "And you will win because only the one with the prize is left to switch to.",
        "So, your only goal is to not choose the door with the prize on the first choice.",
        "That's 2 doors out of 3, which means a 2/3, or 66% chance of winning by switching doors."
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
                                    
                                    if index == 0 {
                                        Image("Pair of Torn Socks")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .padding(.trailing, 130)
                                            .padding(.top, 100)
                                            .opacity(revealItem1 ? 1 : 0)
                                    }
                                    else if index == 1 {
                                        ZStack {
                                            Image("star2")
                                                .resizable()
                                                .frame(width: 130, height: 130)
                                                .rotationEffect(.degrees(rotation))
                                                .onAppear {
                                                    withAnimation(Animation.linear(duration: 9.0).repeatForever(autoreverses: false)) {
                                                        self.rotation = 360.0
                                                    }
                                                }
                                                .opacity(revealStar ? 1 : 0)
                                                .shadow(radius: 4, x: 12, y: 12)
                                            
                                            Image("ex")
                                                .resizable()
                                                .frame(width: 130, height: 130)
                                                .scaleEffect(scalex ? CGSize(width: 0.8, height: 0.8) : CGSize(width: 1.0, height: 1.0))
                                                .onAppear {
                                                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                                        self.scalex.toggle()
                                                    }
                                                }
                                                .shadow(radius: 4, x: 12, y: 12)
                                                .opacity(revealX ? 1 : 0)
                                            
                                            Image("gold")
                                                .resizable()
                                                .frame(width: 130, height: 130)
                                                .opacity(revealItem2 ? 1 : 0)
                                        }
                                        .padding(.trailing, 130)
                                        .padding(.top, 100)
                                    }
                                    else if index == 2 {
                                        Image("Broken Broom")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .padding(.trailing, 130)
                                            .padding(.top, 100)
                                            .opacity(revealItem3 ? 1 : 0)
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
                        if textPosition == 0 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 1)) {
                                self.revealItem2 = true
                            }
                            doorList[1].startAnimation()
                        }
                        else if textPosition == 1 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealItem2 = false
                            }
                            doorList[1].closeDoor()
                            doorList[1].startFlashing()
                            
                            withAnimation(.easeInOut(duration: 1)) {
                                self.revealItem1 = true
                                self.revealItem3 = true
                            }
                            doorList[0].startAnimation()
                            doorList[2].startAnimation()
                        }
                        else if textPosition == 2 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealItem1 = false
                                self.revealItem3 = false
                            }
                            doorList[0].closeDoor()
                            doorList[2].closeDoor()
                            doorList[0].startFlashing()
                            doorList[2].startFlashing()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                imageNameDoor1 = "door1ligthglow"
                                imageNameDoor3 = "door3ligthglow"
                            }
                        }
                        else if textPosition == 3 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 1)) {
                                self.revealItem3 = true
                            }
                            doorList[2].startAnimation()
                            
                        }
                        else if textPosition == 4 {
                            textPosition += 1
                            withAnimation(.easeInOut(duration: 1)) {
                                self.revealMonty = true
                            }
                        }
                        else if textPosition == 5 {
                            textPosition += 1
                            imageNameDoor1 = "door1ligth"
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealMonty = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.revealItem2 = true
                                    self.revealStar = true
                                }
                                doorList[1].startAnimation()
                            }
                            
                        }
                        else if textPosition == 6 {
                            textPosition += 1
                            doorList[1].closeDoor()
                            doorList[2].closeDoor()
                            doorList[1].startFlashing()
                            doorList[2].startFlashing()
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.revealItem2 = false
                                self.revealStar = false
                                self.revealItem3 = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    self.revealX = true
                                }
                            }
                        }
                        else if textPosition == 7 {
                            textPosition += 1
                            self.revealX = false
                            withAnimation(.easeInOut(duration: 1)) {
                                self.reveal50 = true
                            }
                        }
                        else if textPosition == 8 {
                            isNavigationActive = true
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
                
                Image("66%")
                    .resizable()
                    .frame(width: 430, height: 590)
                    .padding(.trailing, 90)
                    .padding(.bottom, 100)
                    .opacity(reveal50 ? 1 : 0)
                    .padding(.leading, 100)
                    .padding(.bottom, 90)
                
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                if goToMenu {
                    MenuView(playSong: false)
                        .ignoresSafeArea()
                } else {
                    ChoseAnotherView(cameFromTryToMiss: true)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

#Preview {
    TryToMiss1(goToMenu: true)
}
