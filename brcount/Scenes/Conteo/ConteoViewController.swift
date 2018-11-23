//
//  ConteoViewController.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/11/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit

enum carType: String{
    case car = "Light"
    case bus = "Medium"
    case truck = "Heavy"
}
enum turnType: String{
    case straight = "straight"
    case rightTurn = "right"
    case leftTurn = "left"
    case uTurn = "uturn"
}

class ConteoViewController: UIViewController {
    @IBOutlet weak var junctionLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    var sessionId: String!
    var junction: String!
    var timeStart: String!
    var timeFinish: String!
    var timer: Timer!
    var started: Bool?
    var timeLeft: (h: Int,m: Int)!
    
    var count: (carType?, turnType?) = (nil,nil){
        didSet{
            let car = count.0
            let turn = count.1
            let laneId = lane?.id
            if car != nil, turn != nil, laneId != nil{
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let seconds = calendar.component(.second, from: date)
                let time = "\(hour):\(minutes):\(seconds)"
                counts.append(CountingItem(id: "",type: car!.rawValue ,hour: time, turn: (turn?.rawValue)!, lane_id: laneId!))
            }
        }
    }
    var counts: [CountingItem] = []
    var countIds: [Int] = []
    var lane: Lane?
    var toggledButton: carType?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        lane = Lane(id: "", name: "carril derecho", operador_id: "4", session_id: sessionId!)
        //cambiar por 60 segundos
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTime), userInfo: nil, repeats: true)
        self.junctionLabel.text = self.junction
        timeLeft = (h: Int(timeFinish.prefix(2))! - Int(timeStart.prefix(2))!,m: Int(timeFinish.suffix(2))!)
    }
    
    @objc func runTime(){
        //cambiar por hora de inicio
        if true ?? false{
            if timeLeft.h == 0, timeLeft.m == 0{
                BetterRideApi.postCountingItems(with: counts)
            }else{
                if timeLeft.m == 0{
                    timeLeft.m = 60
                    timeLeft.h -= 1
                }else{
                    timeLeft.m -= 1
                }
                timeLeftLabel.text = "\(timeLeft.h):\(timeLeft.m)"
            }
            
        }else{
            hasStarted()
        }

    }
    
    func hasStarted(){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        if "\(hour):\(minutes)" == timeStart{
            started = true
        }else{
            started = false
        }
    }
    
    @IBAction func carTap(_ sender: Any) {
        self.count = (.car,nil)
    }
    @IBAction func busTap(_ sender: Any) {
        self.count = (.bus,nil)
    }
    @IBAction func truckTap(_ sender: Any) {
        self.count = (.truck,nil)
    }
    @IBAction func straightTap(_ sender: Any) {
        self.count.1 = .straight
    }
    @IBAction func rightTap(_ sender: Any) {
        self.count.1 = .rightTurn
    }
    @IBAction func leftTap(_ sender: Any) {
        self.count.1 = .leftTurn
    }
    @IBAction func bottomTap(_ sender: Any) {
        self.count.1 = .uTurn

    }
}
