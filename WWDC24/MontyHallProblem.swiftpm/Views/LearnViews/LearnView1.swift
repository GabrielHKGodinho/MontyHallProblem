//
//  LearnView1.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

struct LearnView1: View {
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
                    for (index, doorView) in doorList.enumerated() {
                        startOpeningWithItem(door: doorView, number: index)
                    }
                }
                NavigationLink {
                    LearnView2()
                } label: {
                    ZStack {
                        Image("textNormal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 170)
                        
                        Text("So now that you understand how the game works, I'll show you \nsomething very interesting that is behind it and that many \npeople don't know.")
                            .bold()
                            .font(.system(size: 32))
                    }
                    .opacity(textAppear ? 1 : 0)
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
    LearnView1()
}
