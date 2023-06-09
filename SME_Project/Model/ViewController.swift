//
//  ViewController.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 08/06/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var fromCity: UIPickerView!
    
    @IBOutlet weak var amountT: UITextField!
    
    @IBOutlet weak var toCity: UIPickerView!
    
    
    @IBOutlet weak var toCountL: UILabel!
    
    @IBOutlet weak var fromCountL: UILabel!
    
    let fromCityList = ["USD","EUR", "INR","USD","EUR", "INR","USD","EUR", "INR"]
    let toCityList = ["USD","EUR", "INR"]
//    let fromCurrency = base_code: String
//    let toCurrency = target_code: String
    var result : [CountryInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromCity.dataSource = self
        toCity.dataSource = self
        
        fromCity.delegate = self
        toCity.delegate = self
        
        tbl.dataSource = self
        
      print("asd")
    }

    @IBAction func exchangeB(_ sender: Any) {
        let code = amountT.text ?? ""
        let from = fromCountL.text ?? ""
        let to = toCountL.text ?? ""
        if !code.isEmpty{
            print("get conversion for: \(code)")
            CurrencyUtility.shared.getConvertCurrency(amount: code, from: from, to: to){ convertArray in
                self.result = convertArray
                DispatchQueue.main.sync{
                    self.tbl.reloadData()
                }
                
            }
        }
        else{
            print("enter valid number")
        }
    }
    
}

extension ViewController: UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == fromCity{
            return fromCityList.count
        }
        else{
            return toCityList.count
        }
    }
    
}

extension ViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == fromCity{
            return fromCityList[row]
        }
        else{
            return toCityList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromCity{
            fromCountL.text = "\(fromCityList[row])"
        }
        else{
            
            toCountL.text = "\(toCityList[row])"
            
        }
    }

}
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
 
        let res = result[indexPath.row]
        
        cell.textLabel?.text = "\(res.conversion_result)"
        cell.detailTextLabel?.text = "\(res.conversion_rate)"
        
        return cell
    }
    
    
}
