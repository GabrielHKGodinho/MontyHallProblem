//
//  LearnView2.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 19/02/24.
//

import SwiftUI

// ?
struct LearnView2: View {
    @State var doorList : [DoorView]! = []
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligth"
    @State private var imageNameDoor3 = "door3ligth"
    
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
                }
                NavigationLink {
                    MenuView()
                } label: {
                    ZStack {
                        Image("textNormal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 170)
                        
                        Text("Well, first you choose a door, let's say, door number 2.")
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
}

#Preview {
    LearnView2()
}
