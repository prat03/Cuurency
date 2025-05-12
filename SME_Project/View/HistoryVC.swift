//
//  HistoryVC.swift
//  SME_Project
//
//

import UIKit

class HistoryVC: UIViewController {
    
    var history: [CurrencyConv] = []

    @IBOutlet weak var hisTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        history = HistoryUtility.shared.getAllData()
        hisTbl.dataSource = self
        hisTbl.delegate = self
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
extension HistoryVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteaction = UIContextualAction(style: .destructive, title: "Delete"){ _, _, _ in
            
            let dataToDelete = self.history[indexPath.row]
            HistoryUtility.shared.del(data: dataToDelete)
            self.history.remove(at: indexPath.row)
            self.hisTbl.reloadData()
            print("deleting")
        }
        let config = UISwipeActionsConfiguration(actions: [deleteaction])
        return config
        
    }
}
