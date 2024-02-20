//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 15/02/24.
//

import SwiftUI

struct GameView: View {
    @State private var isNavigationActive: Bool = false
    
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoors = ["door1ligth","door2ligth","door3ligth"]
    
    @State private var doorsEnabled = false
    @State private var doorChosen : Int! = nil
    @State private var doorOpened : Int! = nil
    @State var doorNotChosen : Int!
    @State private var revealItem : Bool = false
    @State private var revealAll : Bool = false
    @State private var finalDecision : Bool = false
    @State private var doorChosenAux : Int! = nil
    
    @State private var confirm : Bool = false
    
    @State private var texts = [
        "Behind 2 of these 3 doors we have not very valuable items.",
        "But behind the other door we have ONE MILLION dollars!",
        "The game is simple, choose a door and whatever is behind it is yours!",
        "Go on, choose your door!"
    ]
    @State private var textAppear = true
    @State var textPosition = 0
    
    @State var doorList : [DoorView]! = []
    
    @State private var doors : [Bool] = []
    @State private var doorsItens : [String] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    HStack(spacing: 90) {
                        ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                            ZStack {
                                Button {
                                    if doorsEnabled {
                                        confirm = true
                                        if !finalDecision {
                                            doorChosen = index + 1
                                        } else {
                                            doorChosenAux = index + 1
                                        }
                                    }
                                } label:{
                                    door
                                        .frame(width: 300)
                                }
                                
                                VStack(spacing: 52) {
                                    Text(((doorChosen ?? 10) - 1 == index) ? "Stay" : "Switch")
                                        .bold()
                                        .font(.system(size: 35))
                                        .foregroundStyle(Color("ligthYellow"))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 1)
                                        .background(Color("darkYellow"))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.bottom, 110)
                                        .zIndex(((doorOpened ?? 10)  - 1 != index && finalDecision) ? 30 : -10)
                                        .opacity(((doorOpened ?? 10)  - 1 != index && finalDecision) ? 1 : 0)
                                    Image(doorsItens[index] )
                                        .resizable()
                                        .frame(maxWidth: 130, maxHeight: 130)
                                        .zIndex((((doorOpened ?? 10)  - 1 == index || revealAll) && revealItem) ? 30 : -10)
                                        .opacity((((doorOpened ?? 10)  - 1 == index || revealAll) && revealItem) ? 30 : -10)
                                }
                                .padding(.trailing, 128)
                                .padding(.bottom, 30)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                    .padding(.top, 100)
                    .padding(.leading, 205)
                    
                    ZStack {
                        Image("textNormal")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 170)
                        
                        Text(texts[textPosition])
                            .bold()
                            .font(.system(size: 32))
                    }
                    .opacity(textAppear ? 1 : 0)
                    .onTapGesture {
                        if textPosition == 6 {
                            if doorList[doorOpened - 1].imageNumber == 1 {
                                doorList[doorOpened - 1].correctName()
                                doorList[doorOpened - 1].startAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeIn(duration: 0.5)){
                                        revealItem = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    textPosition += 1
                                }
                            }
                        }
                        
                        if textPosition == 11 {
                            if doorList[doorChosen - 1].imageNumber == 1 && doorList[doorNotChosen - 1].imageNumber == 1 {
                                doorList[doorChosen - 1].correctName()
                                doorList[doorChosen - 1].startAnimation()
                                
                                doorList[doorNotChosen - 1].correctName()
                                doorList[doorNotChosen - 1].startAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeIn(duration: 0.5)){
                                        revealAll = true
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    textPosition += 1
                                }
                            }
                        }
                        
                        if textPosition != 3 && textPosition != 6 && textPosition != 9 && textPosition != 11 {
                            textPosition += 1
                        }
                        
                        if textPosition == 3 {
                            doorsEnabled = true
                        }
                        if textPosition == 9 {
                            withAnimation(.easeIn(duration: 1.5)){
                                finalDecision = true
                            }
                        }
                        if textPosition == 13 {
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
                
                ZStack {
                    VStack(spacing: 28){
                        Text("Confirm your choice ?")
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 28))
                        
                        HStack{
                            Button {
                                confirm = false
                                
                                if finalDecision {
                                    if doorChosen != doorChosenAux {
                                        doorNotChosen = doorChosen
                                        doorChosen = doorChosenAux
                                    }
                                    let ultimaLetra = imageNameDoors[doorChosen - 1].removeLast()

                                    imageNameDoors[doorChosen - 1].append(contentsOf: "glow")
                                    imageNameDoors[doorChosen - 1].append(ultimaLetra)
                                    finalDecision = false
                                    texts.append("Ok, so let's go to the final result!")
                                    texts.append("Please open the remaining doors!")
                                    
                                    if doors[doorChosen - 1] {
                                        texts.append("Congratulations! You've just won a MILLION dollars worth of gold bars!")
                                    } else {
                                        texts.append("Oooh! I'm sorry, at least you've won a \(doorsItens[doorChosen - 1]).")
                                    }
                                    texts.append(" ")
                                    
                                    textPosition += 1
                                } else {
                                    let ultimaLetra = imageNameDoors[doorChosen - 1].removeLast()

                                    imageNameDoors[doorChosen - 1].append("glow")
                                    imageNameDoors[doorChosen - 1].append(ultimaLetra)
                                    print(imageNameDoors[doorChosen - 1])
                                    texts.append("Okay! So you've chosen door number \(doorChosen!)")
                                    texts.append("Let's make things more interesting...")
                                    
                                    doorOpened = returnRandomEmptyDoor(doors: doors, doorChosen: doorChosen - 1) + 1
                                    
                                    texts.append("Door number \(doorOpened!), open!")
                                    
                                    texts.append("Look, you just avoided winning a " + doorsItens[doorOpened - 1])
                                    
                                    texts.append("Now I want to know...")
                                    
                                    let doorLeft = [doorChosen,doorOpened]
                                    for i in 1...3 {
                                        if !doorLeft.contains(i) {
                                            doorNotChosen = i
                                        }
                                    }
                                    texts.append("Do you want to stick with door number \(doorChosen!), or do you want \nto switch to door number \(doorNotChosen!)?")
                                    
                                    textPosition += 1
                                }
                            } label: {
                                Text("Yes")
                                    .foregroundStyle(.black)
                                    .bold()
                                    .font(.system(size: 28))
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color("darkYellow"))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            Button {
                                confirm = false
                                
                                if !finalDecision{
                                    doorChosen = nil
                                }
                            } label: {
                                Text("No")
                                    .foregroundStyle(.black)
                                    .bold()
                                    .font(.system(size: 28))
                                    .frame(maxWidth: .infinity, maxHeight: 50)
                                    .background(Color("darkYellow"))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding()
                    .frame(width: 300, height: 200)
                    .background(Color("ligthYellow"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black .opacity(0.6))
                
                .zIndex(confirm ? 10 : -10)
            }
            .onAppear{
                doorList = []
                doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoors[0]))
                doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoors[1]))
                doorList.append(DoorView(imageNumber: $imageNumberDoor3, imageName: $imageNameDoors[2]))
                for doorView in doorList {
                    doorView.startFlashing()
                }
                doors = createDoors()
                doorsItens = putItensBehindDoors(doors: doors)
                
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isNavigationActive) {
                MenuView()
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    GameView()
}
