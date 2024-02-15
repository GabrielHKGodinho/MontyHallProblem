//
//  SimulatorView.swift
//  MontyHallProblem
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 01/02/24.
//

import SwiftUI
import Charts

struct SimulatorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var gamesNumber : Int = 100
    @State var stay : Bool = true
    
    @State var gamesWonStay : Int = 0
    @State var gamesLostStay : Int = 0
    @State var percentageWonStay : Int = 0
    @State var percentageLostStay : Int = 0
    
    @State var gamesWonSwitch : Int = 0
    @State var gamesLostSwitch : Int = 0
    @State var percentageWonSwitch : Int = 0
    @State var percentageLostSwitch : Int = 0
    
    @State var dataStay: [Stay] = []
    @State var dataSwitch: [Switch] = []
    
    @State var transitionOpacity = true
    
    var body: some View {
        ZStack {
            VStack{
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            
            VStack(spacing: 12) {//tela toda
                HStack(spacing: 32){//seta voltar e simulator
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    }label: {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 56))
                            .bold()
                    }
                    
                    Text("SIMULATOR")
                        .font(.system(size: 56))
                        .bold()
                    
                    Spacer()
                }
                
                VStack{//botoes
                    VStack{//settings
                        HStack(spacing: 150){
                            VStack(alignment: .trailing, spacing: 24){
                                Text("n° of Games")
                                Text("Stay or Switch?")
                            }
                            .bold()
                            .font(.system(size: 40))
                            
                            VStack(spacing: 24){
                                HStack{// n games
                                    Button(action: {
                                        gamesNumber = gamesNumber == 0 ? 0 : gamesNumber - 100
                                    }, label: {
                                        HStack{
                                            Text("-")
                                                .font(.system(size: 51))
                                        }
                                        .frame(width: 53, height: 53)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        
                                    })
                                    
                                    HStack{
                                        Text("\(gamesNumber)")
                                            .font(.system(size: 51))
                                    }
                                    .frame(width: 164, height: 53)
                                    .background(.gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Button(action: {
                                        gamesNumber = gamesNumber == 9900 ? 9900 : gamesNumber + 100
                                    }, label: {
                                        HStack{
                                            Text("+")
                                                .font(.system(size: 51))
                                        }
                                        .frame(width: 53, height: 53)
                                        .background(.black)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        
                                    })
                                }
                                .bold()
                                
                                HStack {
                                    Button {
                                        stay = true
                                    } label: {
                                        HStack{
                                            HStack{
                                                Text("Stay")
                                                    .font(.system(size: 30))
                                                    .bold()
                                                
                                            }
                                            .padding()
                                            .frame(width: 139, height: 53)
                                            .background(stay ? .black : .gray)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        }
                                    }
                                    Button {
                                        stay = false
                                    } label: {
                                        HStack{
                                            HStack{
                                                Text("Switch")
                                                    .font(.system(size: 30))
                                                    .bold()
                                                
                                            }
                                            .padding()
                                            .frame(width: 139, height: 53)
                                            .background(!stay ? .black : .gray)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        }
                                    }
                                }
                                
                            }
                        }// botoes
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 32)
                        HStack {
                            Button {
                                simulateMultipleGames(number: gamesNumber)
                            } label: {
                                HStack{
                                    Text("SIMULATE")
                                        .font(.system(size: 40))
                                }
                                .frame(width: 300, height: 53)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .padding(.trailing, 16)
                            Button {
                                gamesWonStay = 0
                                gamesLostStay = 0
                                percentageWonStay = 0
                                percentageLostStay = 0
                                
                                gamesWonSwitch = 0
                                gamesLostSwitch = 0
                                percentageWonSwitch = 0
                                percentageLostSwitch = 0
                                
                                dataStay = []
                                dataSwitch = []
                            } label: {
                                HStack{
                                    Text("Reset")
                                        .font(.system(size: 40))
                                }
                                .frame(width: 150, height: 53)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .padding(.bottom, 16)
                        VStack{
                            HStack(spacing: 250){
                                Text("Stay")
                                Text("Switch")
                                Text("% of Wins")
                            }
                            .padding(.top, 16)
                            .padding(.trailing, 40)
                            .font(.system(size: 32))
                            .bold()
                            HStack(spacing: 64){
                                HStack {
                                    VStack(spacing: 100){
                                        VStack{
                                            Text("Games Won")
                                            Text("\(gamesWonStay)")
                                        }
                                        VStack{
                                            Text("Games Lost")
                                            Text("\(gamesLostStay)")
                                        }
                                        .padding(.bottom, 32)
                                    }
                                    VStack(spacing: 100){
                                        VStack{
                                            Text("% Wins")
                                            Text("\(percentageWonStay)")
                                        }
                                        VStack{
                                            Text("% Losses")
                                            Text("\(percentageLostStay)")
                                        }
                                        .padding(.bottom, 32)
                                    }
                                }
                                HStack {
                                    VStack(spacing: 100){
                                        VStack{
                                            Text("Games Won")
                                            Text("\(gamesWonSwitch)")
                                        }
                                        VStack{
                                            Text("Games Lost")
                                            Text("\(gamesLostSwitch)")
                                        }
                                        .padding(.bottom, 32)
                                    }
                                    VStack(spacing: 100){
                                        VStack{
                                            Text("% Wins")
                                            Text("\(percentageWonSwitch)")
                                        }
                                        VStack{
                                            Text("% Losses")
                                            Text("\(percentageLostSwitch)")
                                        }
                                        .padding(.bottom, 32)
                                    }
                                }
                                self.createChartView()
                                    .frame(width: 400, height: 300)
                            }
                            .padding(.bottom, 32)
                            .padding(.top, 16)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 24))
                            .bold()
                        }
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.top, 32)
                }
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 12)
            .background(.white)
            .opacity(transitionOpacity ? 0 : 1)
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        self.transitionOpacity = false
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func createChartView() -> some View {
        return VStack {
            Chart {
                ForEach(dataStay, id: \.date){ dataPoint in
                    LineMark(x: .value(dataPoint.dateLabel, dataPoint.date), y: .value(dataPoint.valueLabel, dataPoint.value))
                        .foregroundStyle(by: .value("STAY", "STAY"))
                }
                ForEach(dataSwitch, id: \.date){ dataPoint in
                    LineMark(x: .value(dataPoint.dateLabel, dataPoint.date), y: .value(dataPoint.valueLabel, dataPoint.value))
                        .foregroundStyle(by: .value("SWITCH", "SWITCH"))
                }
            }
            .chartForegroundStyleScale(["STAY": Color.orange, "SWITCH": Color.blue])
        }
    }
    
    func updateStats(won: Bool, stay: Bool){
        if stay {
            won ? (gamesWonStay += 1) : (gamesLostStay += 1)
            percentageWonStay = gamesWonStay * 100 / (gamesWonStay + gamesLostStay)
            percentageLostStay = gamesLostStay * 100 / (gamesWonStay + gamesLostStay)
            
            dataStay.append(Stay(date: (gamesWonStay + gamesLostStay), value: Double(percentageWonStay)))
        } else {
            won ? (gamesWonSwitch += 1) : (gamesLostSwitch += 1)
            percentageWonSwitch = gamesWonSwitch * 100 / (gamesWonSwitch + gamesLostSwitch)
            percentageLostSwitch = gamesLostSwitch * 100 / (gamesWonSwitch + gamesLostSwitch)
            
            dataSwitch.append(Switch(date: (gamesWonSwitch + gamesLostSwitch), value: Double(percentageWonSwitch)))
        }
    }
    
    func simulateMultipleGames(number: Int){
        
        for _ in 1...number{
            updateStats(won: simulateOneGame(stay: stay), stay: stay)
        }
    }
}

#Preview {
    SimulatorView()
}

