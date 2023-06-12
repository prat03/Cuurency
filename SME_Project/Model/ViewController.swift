//
//  ViewController.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 08/06/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var rateL: UILabel!
    
    @IBOutlet weak var outputL: UILabel!
    
    
    @IBOutlet weak var fromCity: UIPickerView!
    
    @IBOutlet weak var amountT: UITextField!
    
    @IBOutlet weak var toCity: UIPickerView!
    
    
    @IBOutlet weak var toCountL: UILabel!
    
    @IBOutlet weak var fromCountL: UILabel!
    
    
    let fromCityList = ["USD","EUR", "INR","USD","EUR", "INR","USD","EUR", "INR"]
    let toCityList = ["USD","EUR", "INR"]

    var result: CountryInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromCity.dataSource = self
        toCity.dataSource = self
        
        fromCity.delegate = self
        toCity.delegate = self
        
      print("asd")
    }

    @IBAction func exchangeB(_ sender: Any) {
        let code = amountT.text ?? ""
        let from = fromCountL.text ?? ""
        let to = toCountL.text ?? ""
        
        if !code.isEmpty{
            print("get conversion for: \(code)")
            CurrencyUtility.shared.getConvertCurrency(amount: code, from: from, to: to){ convert in
                self.result = convert
                DispatchQueue.main.sync{
                    self.outputL.text = "Converted Value: \(convert.conversion_result)"
                    self.rateL.text = "Converted Rate: \(convert.conversion_rate)"
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
