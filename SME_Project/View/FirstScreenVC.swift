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
    var searchedF: [CountryCodes] = []
    var searchedT: [CountryCodes] = []
   var searchingF = false
    var searchingT = false

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
    var array: [String] = [] //api to tableview save for country
    var array2: [String] = [] // api to tableview save for code
    var result: CountryInfo?
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fromsearch.delegate = self
        self.tosearch.delegate = self
        
        table = CountryServerUtility.shared.getAllData()  // api to coredata country n code
        
        
        //activity indicator
        progressAI.isHidden = true
        
        //searchbar
        fromsearch.isHidden = true
        tosearch.isHidden = true
        
        //tableview
        fromtbl.isHidden = true
        totbl.isHidden = true
        
        fromtbl.dataSource = self
        fromtbl.delegate = self
        totbl.dataSource = self
        totbl.delegate = self
        
        print("\(NSHomeDirectory())") //home
        
        //api to tableview
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
 
    //Button animate
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
    
    // convert button
    @IBAction func exchangeB(_ sender: Any) {
        //activity indicator
        self.progressAI.isHidden = false
        progressAI.startAnimating()
        // conversion
        let number = amountTF.text ?? ""
        let from = fromL.text ?? ""
        let to = toL.text ?? ""
        
        // Error
        if !number.isEmpty && (from.count == 3) && (to.count == 3){
            print("get conversion for: \(number)")
            ConversionUtility.shared.getConvertCurrency(amount: number, from: from, to: to){ convert in
                self.result = convert //get
                DispatchQueue.main.sync{
                    self.progressAI.stopAnimating()
                    self.progressAI.isHidden = true
                    self.outputL.text = "\(convert.conversion_result)"
                    self.rateL.text = "Converted Rate: \(convert.conversion_rate)"
                    self.outputCodeL.text = "\(to):"
                    HistoryUtility.shared.addData(amount: number, fromcount: from, toCount: to, conAmt: self.outputL.text ?? "", conRate: self.rateL.text ?? "") //save
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

    
  
}

extension FirstScreenVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == totbl{
            if searchingT{
                return searchedT.count
            }
            else{
                return table.count
            }
        }else{
            if searchingF{
                return searchedF.count
            }
            else{
                return table.count
            }
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == fromtbl{
            let cell = tableView.dequeueReusableCell(withIdentifier: "fromcell", for: indexPath) as! FromCell
            
          let fromcountry = table[indexPath.row]
            
            if searchingF{
                cell.country.text = searchedF[indexPath.row].countries
            cell.code.text = searchedF[indexPath.row].code
            }
            else{
                cell.country.text = fromcountry.countries
                cell.code.text = fromcountry.code
            }
            //api fetch
//            let fromcode = array2.sorted()[indexPath.row]
//            cell.country.text = "\(fromcountry)"
//            cell.code.text = "\(fromcode)"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "tocell", for: indexPath) as! ToCell

            let tocountry = table[indexPath.row]
            if searchingT{
                cell.tocountry.text = searchedT[indexPath.row].countries
                cell.tocode.text = searchedT[indexPath.row].code
            }
            else{
                cell.tocountry.text = tocountry.countries
                cell.tocode.text = tocountry.code
            }
            
            // api fetch
//            let tocode = array2.sorted()[indexPath.row]
            //cell.tocountry.text = "\(tocountry)"
            //cell.tocode.text = "\(tocode)"

            // api fetch
         //  CountryServerUtility.shared.addCountryCode(country: tocountry, code: tocode)
            return cell
        }
    }
}

extension FirstScreenVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       // let fromcountry = table[indexPath.row]
       
        
        if tableView == fromtbl{
//            fromL.text = fromcountry.code
//            //fromL.text = array2[indexPath.row]
//            animate(toggle: false)
            
            if searchingF{
                let selectedCountry = searchedF[indexPath.row]
                fromL.text = searchedF[indexPath.row].code
                //fromL.text = array2[indexPath.row]
                animate(toggle: false)
                print(selectedCountry)
            }else{
                let selectedCountry = table[indexPath.row]
                print(selectedCountry)
            }
            self.fromsearch.searchTextField.endEditing(true)
        }
        
        else{
//            toL.text = fromcountry.code
//            //toL.text = "\(array2[indexPath.row])"
//            animate2(toggle1: false)
            if searchingT{
                let selectedCountry = searchedT[indexPath.row]
                toL.text = searchedT[indexPath.row].code
                            //toL.text = "\(array2[indexPath.row])"
                animate2(toggle1: false)
                print(selectedCountry)
            }else{
                let selectedCountry = table[indexPath.row]
                print(selectedCountry)
            }
            self.tosearch.searchTextField.endEditing(true)
        }
            
        }
        
    }
    

extension FirstScreenVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar == fromsearch{
            searchedF =  table.filter{ $0.countries?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            searchingF = true
            print("searching")
            fromtbl.reloadData()
        }
        else{
            searchedT =  table.filter{ $0.countries?.lowercased().prefix(searchText.count) ?? "" == searchText.lowercased()}
            searchingT = true
            print("searching")
            totbl.reloadData()
        }
    }
    
}
