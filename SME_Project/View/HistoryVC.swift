//
//  HistoryVC.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 13/06/23.
//

import UIKit

class HistoryVC: UIViewController {
    
    var history: [CurrencyConv] = []

    @IBOutlet weak var hisTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        history = Utility.shared.getAllData()
        hisTbl.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension HistoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histcell", for: indexPath) as! HistoryCell
        
        let data = history[indexPath.row]
        
        cell.frmL.text = data.fromCoun
        cell.toL.text = data.toCoun
        cell.amtL.text = data.amount
        cell.conamtL.text = data.cAmt
        return cell
        
    }
    
    
}
