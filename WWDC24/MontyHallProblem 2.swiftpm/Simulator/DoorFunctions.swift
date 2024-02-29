//
//  File.swift
//  
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 02/02/24.
//

import Foundation

private let numberOfItens : UInt32 = 5

func simulateOneGame(stay: Bool) -> Bool{
    let doors = createDoors()
    
    //Choose door
    var doorChosen = Int(arc4random_uniform(3))
    
    if !stay {
        doorChosen = open1DoorAndSwitch(doors: doors, doorChosen: doorChosen)
    }
    
    return doors[doorChosen] ? true : false
}

func createDoors() -> [Bool]{
    let randomNum = Int(arc4random_uniform(3))
    var doors: [Bool] = []
    
    switch randomNum {
    case 0:
        doors.append(true)
        doors.append(false)
        doors.append(false)
    case 1:
        doors.append(false)
        doors.append(true)
        doors.append(false)
    case 2:
        doors.append(false)
        doors.append(false)
        doors.append(true)
    default:
        fatalError("Unexpected random number encountered when setting up the doors.")
    }
    
    return doors
}

func open1DoorAndSwitch(doors: [Bool], doorChosen: Int) -> Int {
    var doorsClosed : Int!
    
    var doorsNotChosen = [0,1,2]
    doorsNotChosen.remove(at: doorChosen)
    
    if doors[doorsNotChosen[0]] {
        doorsClosed = doorsNotChosen[0]
    }
    else if doors[doorsNotChosen[1]] {
        doorsClosed = doorsNotChosen[1]
    }
    else {
        let randomNum = Int(arc4random_uniform(2))
        
        doorsClosed = doorsNotChosen[randomNum]
    }
    
    return doorsClosed
    
}

func returnRandomEmptyDoor(doors: [Bool], doorChosen: Int) -> Int {
    var doorsClosed : Int!
    
    var doorsNotChosen = [0,1,2]
    doorsNotChosen.remove(at: doorChosen)
    
    if doors[doorsNotChosen[0]] {
        doorsClosed = doorsNotChosen[1]
    }
    else if doors[doorsNotChosen[1]] {
        doorsClosed = doorsNotChosen[0]
    }
    else {
        let randomNum = Int(arc4random_uniform(2))
        
        doorsClosed = doorsNotChosen[randomNum]
    }
    
    return doorsClosed
    
}

func putItensBehindDoors(doors: [Bool]) -> [String] {
    let itensNames = [
        "Broken Broom",
        "Deflated Ball",
        "Rotten Apple",
        "Scratched Disc",
        "Pair of Torn Socks"
    ]
    
    let randomNum1 = Int(arc4random_uniform(numberOfItens))
    var randomNum2 = randomNum1
    
    while randomNum2 == randomNum1 {
        randomNum2 = Int(arc4random_uniform(numberOfItens))
    }
    
    var itens : [String] = []
    
    if doors[0] {
        itens.append("gold")
    }
    itens.append(itensNames[randomNum1])
    if doors[1] {
        itens.append("gold")
    }
    itens.append(itensNames[randomNum2])
    if doors[2] {
        itens.append("gold")
    }
    
    return itens
}

func getRandomItem() -> String {
    let itensNames = [
        "Broken Broom",
        "Deflated Ball",
        "Rotten Apple",
        "Scratched Disc",
        "Pair of Torn Socks",
        "gold"
    ]
    
    let randomNum1 = Int(arc4random_uniform(numberOfItens + 1))
    
    return itensNames[randomNum1]
}

