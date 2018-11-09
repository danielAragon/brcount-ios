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
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    func initialSetup(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        sesiones = [
            Sesion(dia: "7 de Mayo", lugar: "Av Tupac Amaru con\n Av Salaverry", hora: "7:00 - 9:00", active: true),
            Sesion(dia: "9 de Junio", lugar: "Av Pershing con\n Av Ricardo Palma", hora: "7:00 - 9:00", active: true)]
    }
    struct Sesion{
        var dia: String
        var lugar: String
        var hora: String
        var active: Bool
    }
    
    var sesiones: [Sesion]?
}
extension SesionesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sesiones!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SesionCell", for: indexPath) as! SesionCell
        cell.dayLabel.text = sesiones![indexPath.row].dia
        cell.hourLabel.text = sesiones![indexPath.row].lugar
        cell.dayLabel.text = sesiones![indexPath.row].hora
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showCounting", sender: nil)
    }
    
}
