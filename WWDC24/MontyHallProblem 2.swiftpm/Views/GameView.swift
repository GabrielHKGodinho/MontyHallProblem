//
//  SwiftUIView.swift
//
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 15/02/24.
//

import SwiftUI

struct GameView: View {
    let soundManager = SoundManager()
    @State private var isNavigationActive: Bool = false
    
    @State private var imageNumberDoor1 = 1
    @State private var imageNumberDoor2 = 1
    @State private var imageNumberDoor3 = 1
    @State private var imageNameDoor1 = "door1ligth"
    @State private var imageNameDoor2 = "door2ligth"
    @State private var imageNameDoor3 = "door3ligth"
    
    @State private var doorsEnabled = false
    @State private var doorChosen : Int! = nil
    @State private var doorOpened : Int! = nil
    @State var doorNotChosen : Int!
    @State private var revealItem : Bool = false
    @State private var revealAll : Bool = false
    @State private var finalDecision : Bool = false
    @State private var doorChosenAux : Int! = nil
    
    @State private var confirm : Bool = false
    
    @State private var rotation: Double = 0.0
    
    @State private var texts = [
        "Behind one of these 3 doors we have ONE MILLION \ndollars worth in gold bars.",
        "And behind the other two, we have... well... \nyou won't want the other prizes...",
        "The game is simple, choose a door and whatever is behind it is yours!",
        "Go on, choose your door!"
    ]
    @State private var textAppear = true
    @State var textPosition = 0
    
    @State var doorList : [DoorView]! = []
    
    @State private var doors : [Bool] = []
    @State private var doorsItens : [String] = []
    @State private var scaleDoors = [false, false, false]
    @State private var updown = false
    @State private var scalex = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack{
                    HStack(spacing: 90) {
                        ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                            ZStack(alignment: .center) {
                                Button {
                                    if doorsEnabled && doorOpened != index + 1 {
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
                                        .scaleEffect(scaleDoors[index] ? CGSize(width: 1.05, height: 1.05) : CGSize(width: 1.0, height: 1.0))
                                }
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
                            .frame(height: 170)
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
                                .opacity( (textPosition == 3 || textPosition == 9) ? 0 : 1 )
                        }
                        .frame(width: 900)
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
                            }
                            if revealItem {
                                textPosition += 1
                            }
                        }
                        
                        else if textPosition == 11 {
                            if doorList[doorChosen - 1].imageNumber == 1 && doorList[doorNotChosen - 1].imageNumber == 1 {
                                doorList[doorChosen - 1].correctName()
                                doorList[doorChosen - 1].startAnimation()
                                
                                doorList[doorNotChosen - 1].correctName()
                                doorList[doorNotChosen - 1].startAnimation()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeIn(duration: 0.5)){
                                        revealAll = true
                                    }
                                    if doors[doorChosen - 1] {
                                        soundManager.play(sound: .applause)
                                    } else {
                                        soundManager.play(sound: .aww)
                                    }
                                    
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    textPosition += 1
                                }
                            }
                        }
                        
                        else if textPosition != 3 && textPosition != 6 && textPosition != 9 && textPosition != 11 {
                            textPosition += 1
                        }
                        
                        if textPosition == 3{
                            doorsEnabled = true
                            for i in 0...2 {
                                startAnimation(index: i)
                            }
                        }
                        if textPosition == 9 {
                            doorsEnabled = true
                            for i in 0...2 {
                                if doorOpened != i + 1 {
                                    startAnimation(index: i)
                                }
                            }
                            withAnimation(.easeIn(duration: 1.5)){
                                finalDecision = true
                            }
                        }
                        if textPosition == 13 {
                            soundManager.stop(sound: .backgroundGame)
                            soundManager.stop(sound: .applause)
                            soundManager.stop(sound: .aww)
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
                
                VStack
                {
                    HStack(spacing: 190) {
                        ForEach(Array(doorList.enumerated()), id: \.offset){ index, door in
                            VStack {
                                if ((doorOpened ?? 10)  - 1 != index && finalDecision) {
                                    Text(((doorChosen ?? 10) - 1 == index) ? "Stay" : "Switch")
                                        .bold()
                                        .frame(width: 120)
                                        .font(.system(size: 35))
                                        .foregroundStyle(Color("ligthYellow"))
                                        .padding(.vertical, 1)
                                        .background(Color("red"))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.bottom, 450)
                                        .padding(.trailing, 95)
                                }
                                
                                if (((doorOpened ?? 10)  - 1 == index || revealAll) && revealItem){
                                    ZStack {
                                        if doorChosen == index + 1 {
                                            if doors[index] {
                                                Image("star2")
                                                    .resizable()
                                                    .frame(width: 200, height: 200)
                                                    .rotationEffect(.degrees(rotation))
                                                    .onAppear {
                                                        withAnimation(Animation.linear(duration: 9.0).repeatForever(autoreverses: false)) {
                                                            self.rotation = 360.0
                                                        }
                                                    }
                                                    .shadow(radius: 4, x: 12, y: 12)
                                            } else {
                                                Image("ex")
                                                    .resizable()
                                                    .frame(width: 200, height: 200)
                                                    .scaleEffect(scalex ? CGSize(width: 0.8, height: 0.8) : CGSize(width: 1.0, height: 1.0))
                                                    .onAppear {
                                                        withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                                                            self.scalex.toggle()
                                                        }
                                                    }
                                                    .shadow(radius: 4, x: 12, y: 12)
                                            }
                                            
                                        }
                                        Image(doorsItens[index] )
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                    }
                                    .padding(.trailing, 100)
                                    .padding(.top, 100)
                                }
                            }
                            .frame(width: 200)
                        }
                    }
                    .padding(.bottom, 120)
                    .padding(.top, 100)
                    .padding(.leading, 180)
                }
                
                ZStack {
                    VStack(spacing: 28){
                        Text("Confirm your choice ?")
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 28))
                        
                        HStack{
                            Button {
                                doorsEnabled = false
                                confirm = false
                                
                                if finalDecision {
                                    if doorChosen != doorChosenAux {
                                        doorList[doorChosen - 1].imageName = doorList[doorChosen - 1].imageName.replacingOccurrences(of: "glow", with: "")
                                        doorNotChosen = doorChosen
                                        doorChosen = doorChosenAux
                                        doorList[doorChosen - 1].imageName.append("glow")
                                    }
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
                                    doorList[doorChosen - 1].imageName.append("glow")
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
                soundManager.play(sound: .backgroundGame)
                doorList = []
                doorList.append(DoorView(imageNumber: $imageNumberDoor1, imageName: $imageNameDoor1))
                doorList.append(DoorView(imageNumber: $imageNumberDoor2, imageName: $imageNameDoor2))
                doorList.append(DoorView(imageNumber: $imageNumberDoor3, imageName: $imageNameDoor3))
                for doorView in doorList {
                    doorView.startFlashing()
                }
                doors = createDoors()
                doorsItens = putItensBehindDoors(doors: doors)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                        self.updown.toggle()
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isNavigationActive) {
                MenuView(playSong: true)
                    .ignoresSafeArea()
            }
        }
    }
    
    func startAnimation(index: Int) {
        if !scaleDoors[index] {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                withAnimation(.easeInOut(duration: 0.5)){
                    scaleDoors[index].toggle()
                }
                
                if textPosition == 4 || textPosition == 10 {
                    timer.invalidate()
                    scaleDoors[index] = false
                }
            }
        }
    }
}

#Preview {
    GameView()
}
