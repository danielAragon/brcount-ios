//
//  SesionesViewController.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/9/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import UIKit
class SesionCell: UITableViewCell{
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var junctionLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
}

class SesionesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var sessions: [Session]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        BetterRideApi.getSessions(operatorId: 4, status: .pendiente, responseHandler: handler)
    }
    
    func handler(data: SessionResponse){
        sessions = data.sessions!
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = (tableView.indexPathForSelectedRow?.row)!
        if segue.identifier == "showCounting" {
            if let vc = segue.destination as? ConteoViewController {
                let session = sessions![row]
                let junction = "\(session.avenue_first ?? "") con \n\(session.avenue_second ?? "")"
                vc.sessionId = sessions![row].id
                vc.junction = junction
                vc.timeStart = String((session.started_at?.prefix(5))!)
                vc.timeFinish = String((session.finished_at?.prefix(5))!)
            }
        } else if segue.identifier == "showReporting" {
//            if let vc = segue.destination as? ReporteViewController {
//                vc. = ""
//            }
        }
    }

    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            BetterRideApi.getSessions(operatorId: 4, status: .pendiente, responseHandler: handler)
        case 1:
            BetterRideApi.getSessions(operatorId: 4, status: .realizado, responseHandler: handler)
        default:
            break
        }
    }
    
}
extension SesionesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SesionCell", for: indexPath) as! SesionCell
        let session = sessions![indexPath.row]
        let junction = "\(session.avenue_first ?? "") con \n\(session.avenue_second ?? "")"
        let schedule = "\(session.started_at?.prefix(5) ?? "") - \(session.finished_at?.prefix(5) ?? "")"
        
        cell.dayLabel.text = session.date
        cell.junctionLabel.text = junction
        cell.hourLabel.text = schedule
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.performSegue(withIdentifier: "showCounting", sender: nil)
        case 1:
            self.performSegue(withIdentifier: "showReporting", sender: nil)
        default:
            break
        }
    }
    
}
