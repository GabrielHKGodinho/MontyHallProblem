//
//  File.swift
//  
//
//  Created by Gabriel Henrique Kwiatkovski Godinho on 02/02/24.
//

import Foundation

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

