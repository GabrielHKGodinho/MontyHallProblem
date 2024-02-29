//
//  MoreDoorsView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 24/02/24.
//

import SwiftUI

struct MoreDoorsView: View {
    var goToMenu: Bool
    @State private var isNavigationActive: Bool = false
    
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor98 = 1
    @State private var imageNameDoor1 = "Normal"
    @State private var imageNameDoor2 = "Normal"
    @State private var imageNameDoor98 = "Normal"
    @State private var revealPercentages = false
    
    @State var doorList : [DoorView]! = []
    @State private var updown = false
    
    let texts = [
        "Imagine that instead of 3 doors, we have 40 doors.",
        "And the logic is the same; you choose one door...",
        "And the host opens the other 38 doors that he knows do not contain the prize.",
        "Then he asks if you want to switch doors or stick with the same one.",
        "Here it becomes clearer that the chance is not 50% for each door because you probably did not choose the right door initially."
    ]
    @State var textPosition = 0
    
    var body: some View {
        NavigationStack {
            ZStack{
                VStack {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 10), spacing: 10) {
                        ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                            door
                        }
                    }
                    .onAppear{
                        doorList = []
                        for _ in 1...9 {
                            doorList.append(DoorView(imageNumber: $imageNumberDoor98, imageName: $imageNameDoor98))
                        }
                        doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoor1))
                        for _ in 1...28 {
                            doorList.append(DoorView(imageNumber: $imageNumberDoor98, imageName: $imageNameDoor98))
                        }
                        doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoor2))
                        doorList.append(DoorView(imageNumber: $imageNumberDoor98, imageName: $imageNameDoor98))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                self.updown.toggle()
                            }
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
                            imageNameDoor1 = "Normalglow"
                        }
                        else if textPosition == 1 {
                            textPosition += 1
                            doorList[0].startAnimation()
                        }
                        else if textPosition == 2 {
                            textPosition += 1
                            imageNameDoor2 = "Normalglow"
                        }
                        else if textPosition == 3 {
                            textPosition += 1
                            withAnimation(Animation.easeOut(duration: 0.5)) {
                                self.revealPercentages = true
                            }
                        }
                        else if textPosition == 4 {
                            isNavigationActive = true
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("ligthRed"))
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 10), spacing: 10) {
                    ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                        Image(index == 38 ? "97%" : "3%")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 30)
                            .opacity((revealPercentages && (index == 9 || index == 38)) ? 1 : 0)
                            
                    }
                }
                .padding(.bottom, 150)
            }
            .navigationBarBackButtonHidden()
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isNavigationActive) {
                MoreDoors2View(goToMenu: goToMenu)
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    MoreDoorsView(goToMenu: true)
}
