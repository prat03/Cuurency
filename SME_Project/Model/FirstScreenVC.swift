//
//  FirstScreenVCViewController.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 21/06/23.
//

import Foundation
import UIKit
import CoreData

class FirstScreenVC: UIViewController {
    
    
    var table: [CountryCodes] = []
   

    @IBOutlet weak var fromL: UILabel!
    
    @IBOutlet weak var toL: UILabel!
    
    
    @IBOutlet weak var rateL: UILabel!
    
    @IBOutlet weak var outputCodeL: UILabel!
    
    @IBOutlet weak var outputL: UILabel!
    
    @IBOutlet weak var amountTF: UITextField!
    
    
    @IBOutlet weak var fromtbl: UITableView!
    
    @IBOutlet weak var totbl: UITableView!
    
    @IBOutlet weak var fromsearch: UISearchBar!
    
    
    @IBOutlet weak var progressAI: UIActivityIndicatorView!
    
    @IBOutlet weak var tosearch: UISearchBar!
    
    var countryList: [CountryDetails] = []
    var array: [String] = []
    var array2: [String] = []
    
    var result: CountryInfo?
    
    var searchFC = [CountryCodes]()
    var searchTC = [CountryCodes]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromsearch.delegate = self
        tosearch.delegate = self
        
      table = CountryServerUtility.shared.getAllData()
        fromtbl.isHidden = true
        totbl.isHidden = true
        
        progressAI.isHidden = true
        
        fromsearch.isHidden = true
        tosearch.isHidden = true
        
        fromtbl.dataSource = self
        fromtbl.delegate = self
        totbl.dataSource = self
        totbl.delegate = self
        print("\(NSHomeDirectory())")
        
//        currencyutility.shared.countries { countryResult in
//
//            self.countryList = countryResult
//
//            countryResult[0].supported_codes.forEach { country in
//                self.array.append(country[1])
//                self.array2.append(country[0])
//            }
//
//            let line = self.countryList[0].supported_codes[0][1]
//            DispatchQueue.main.async {
//                self.fromtbl.reloadData()
//                self.totbl.reloadData()
//            }
//
//        }
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
    
    
    @IBAction func exchangeB(_ sender: Any) {
        self.progressAI.isHidden = false
        progressAI.startAnimating()
        
        let code = amountTF.text ?? ""
        let from = fromL.text ?? ""
        let to = toL.text ?? ""
        
        
        if !code.isEmpty && (from.count == 3) && (to.count == 3){
            print("get conversion for: \(code)")
            CurrencyUtility.shared.getConvertCurrency(amount: code, from: from, to: to){ convert in
                self.result = convert
                DispatchQueue.main.sync{
                    self.progressAI.stopAnimating()
                    self.progressAI.isHidden = true
                    self.outputL.text = "\(convert.conversion_result)"
                    self.rateL.text = "Converted Rate: \(convert.conversion_rate)"
                    self.outputCodeL.text = "\(to):"
                    Utility.shared.addData(amount: code, fromcount: from, toCount: to, conAmt: self.outputL.text ?? "", conRate: self.rateL.text ?? "")
                }
                
            }
        }
        else{
            
            print("enter valid number")
        showErrorAlert(title: "Error", msg: "Enter all the details"){
            
            }
            
            
        }
       
    }
    func showErrorAlert(title:String, msg: String, handler: @escaping () -> Void){
        
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true)
        self.progressAI.stopAnimating()
        self.progressAI.isHidden = true
    }
//    func showErrorAction(title:String, msg: String, handler: @escaping () -> Void){
//
//        let action = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
//
//        let okAction = UIAlertAction(title: "OK", style: .default)
//        action.addAction(okAction)
//
//        present(action, animated: true)
//    }
    
    
    func animate(toggle: Bool){
        if toggle{
            UIView.animate(withDuration: 0.3){
                self.fromtbl.isHidden = false
                self.fromsearch.isHidden = false
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.fromtbl.isHidden = true
                self.fromsearch.isHidden = true
            }
        }
    }
    func animate2(toggle1: Bool){
        if toggle1{
            UIView.animate(withDuration: 0.3){
                self.totbl.isHidden = false
                self.tosearch.isHidden = false
                
            }
        }else{
            UIView.animate(withDuration: 0.3){
                self.totbl.isHidden = true
                self.tosearch.isHidden = true
            }
        }
    }
}

extension FirstScreenVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == totbl{
            return table.count
        }else{
            
            return table.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == fromtbl{
            let cell = tableView.dequeueReusableCell(withIdentifier: "fromcell", for: indexPath) as! FromCell
            
          let fromcountry = table[indexPath.row]
//            let fromcode = array2.sorted()[indexPath.row]
//
//            cell.country.text = "\(fromcountry)"
//            cell.code.text = "\(fromcode)"
            cell.country.text = fromcountry.countries
        cell.code.text = fromcountry.code
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tocell", for: indexPath) as! ToCell

            let tocountry = table[indexPath.row]
//            let tocode = array2.sorted()[indexPath.row]
//
//            cell.tocountry.text = "\(tocountry)"
//            cell.tocode.text = "\(tocode)"
            cell.tocountry.text = tocountry.countries
            cell.tocode.text = tocountry.code
         //  CountryServerUtility.shared.addCountryCode(country: tocountry, code: tocode)
            return cell
        }
    }
}

extension FirstScreenVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let fromcountry = table[indexPath.row]
       
        
        if tableView == fromtbl{
            fromL.text = fromcountry.code
            //fromL.text = array2[indexPath.row]
            animate(toggle: false)
        }
        else{
            toL.text = fromcountry.code
            //toL.text = "\(array2[indexPath.row])"
            animate2(toggle1: false)
        }
        
    }
    
}

extension FirstScreenVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == fromsearch{
            
        }
    }
}
