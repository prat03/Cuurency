//
//  TableViewController.swift
//  SME_Project
//
//  Created by V, Giriprasath (Contractor) on 13/06/23.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var fromL: UILabel!
    
    @IBOutlet weak var toL: UILabel!
    
    @IBOutlet weak var fromtbl: UITableView!
    
    @IBOutlet weak var totbl: UITableView!
    
    var countryList: [CountryDetails] = []
    var array: [String] = []
    var array2: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromtbl.isHidden = true
        totbl.isHidden = true
        
        fromtbl.dataSource = self
        fromtbl.delegate = self
        totbl.dataSource = self
        totbl.delegate = self
        
        currencyutility.shared.countries { countryResult in
            
            self.countryList = countryResult
            
            countryResult[0].supported_codes.forEach { country in
                self.array.append(country[1])
                self.array2.append(country[0])
            }

            let line = self.countryList[0].supported_codes[0][1]
            DispatchQueue.main.async {
                self.fromtbl.reloadData()
                self.totbl.reloadData()
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func fromB(_ sender: Any) {
        if fromtbl.isHidden{
            animate(toggle: true)
        }
        else{
            animate(toggle: false)
        }
    }
    
   
    @IBAction func toB(_ sender: Any) {
        if totbl.isHidden{
            animate2(toggle1: true)
        }
        else{
            animate2(toggle1: false)
        }
    }
    func animate(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.fromtbl.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.fromtbl.isHidden = true
            }
        }
    }
    func animate2(toggle1: Bool){
        if toggle1{
            UIView.animate(withDuration: 0.3){
                self.totbl.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.totbl.isHidden = true
            }
        }
    }
}

extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == totbl{
            return array2.count
        }else{
            
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == fromtbl{
            let cell = tableView.dequeueReusableCell(withIdentifier: "fromcell", for: indexPath) as! FromTableViewCell
            
            let fromcountry = array.sorted()[indexPath.row]
            let fromcode = array2.sorted()[indexPath.row]
            
            //cell.code.text = "\(code)"
            cell.country.text = "\(fromcountry)"
            cell.code.text = "\(fromcode)"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tocell", for: indexPath) as! ToTableViewCell
            
            let tocountry = array.sorted()[indexPath.row]
            let tocode = array2.sorted()[indexPath.row]
            
            //cell.code.text = "\(code)"
            cell.tocountry.text = "\(tocountry)"
            cell.tocode.text = "\(tocode)"
            return cell
        }
    }
}

extension TableViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == fromtbl{
            fromL.text = array2[indexPath.row]
            animate(toggle: false)
        }
        else{
            toL.text = "\(array2[indexPath.row])"
            animate2(toggle1: false)
        }
        
    }
}

