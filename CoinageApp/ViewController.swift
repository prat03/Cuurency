//
//  ViewController.swift
//  CoinageApp
//
//  Created by Leena, Jayakumar (Contractor) on 08/06/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var fromCity: UIPickerView!
    
    
    @IBOutlet weak var toCity: UIPickerView!
    
    let fromCityList = ["USD","EUR", "INR"]
    let toCityList = ["USD","EUR", "INR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromCity.dataSource = self
        toCity.dataSource = self
        
        fromCity.delegate = self
        toCity.delegate = self
        
      
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
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectionlistL.text = "Selected city: \(citylist[row])"
//    }

}
