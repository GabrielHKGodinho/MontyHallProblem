//
//  MoreDoors2View.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

struct MoreDoors2View: View {
    var goToMenu: Bool
    
    @State private var isNavigationActive: Bool = false
    
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligth"
    @State private var imageNameDoor3 = "door3ligth"
    @State private var forwardDoor = [true, true, true]
    @State private var openDoor = [false, false, false]
    
    @State private var textAppear = false
    @State var textPosition = 0
    @State private var updown = false
    @State private var texts = [
        "So when we have 3 doors, the chance of winning by switching is 2/3, because the probability of choosing the right one initially is 1/3."
    ]
    var body: some View {
        NavigationStack {
            VStack {
                VStack{
                    HStack(spacing: 90) {
                        ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                            ZStack {
                                door
                                    .frame(width: 300)
                                
                                if openDoor[index] {
                                    Image(getRandomItem())
                                        .resizable()
                                        .frame(maxWidth: 130, maxHeight: 130)
                                        .padding(.trailing, 140)
                                        .padding(.top, 100)
                                }
                            }
                            
                        }
                    }
                    .padding(.leading, 100)
                    .padding(.bottom, 90)
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeIn(duration: 1)) {
                            self.textAppear = true
                        }
                    }
                    
                    doorList = []
                    doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoor1))
                    doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoor2))
                    doorList.append(DoorView(imageNumber: $imageNumberDoor3, imageName: $imageNameDoor3))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                            self.updown.toggle()
                        }
                    }
                    for (index, doorView) in doorList.enumerated() {
                        startOpeningWithItem(door: doorView, number: index)
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
                    isNavigationActive = true
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(){
                Image("stage")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fill)
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                if goToMenu {
                    MenuView(playSong: false)
                        .ignoresSafeArea()
                } else {
                    ChoseAnotherView(cameFromTryToMiss: false)
                        .ignoresSafeArea()
                }
            }
        }
    }
    
    func startOpeningWithItem(door: DoorView, number: Int) {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            
            let open = Int(arc4random_uniform(2))
            
            if open == 1 {
                openAndClose(door: door, number: number)
            }
            
        }
    }
    
    func openAndClose(door: DoorView, number: Int) {
        withAnimation(.easeIn(duration: 1)) {
            openDoor[number] = true
        }
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            door.imageNumber = forwardDoor[number] ? door.imageNumber + 1 : door.imageNumber - 1
            if door.imageNumber >= 7 {
                forwardDoor[number] = false
            }
            
            if door.imageNumber == 4 && !forwardDoor[number] {
                withAnimation(.easeIn(duration: 0.5)) {
                    openDoor[number] = false
                }
            }
            
            if door.imageNumber == 1 {
                forwardDoor[number] = true
                timer.invalidate()
            }
        }
    }
}

#Preview {
    MoreDoors2View(goToMenu: true)
}
