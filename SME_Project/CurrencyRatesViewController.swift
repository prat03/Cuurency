//
//  CurrencyRatesViewController.swift
//  SME_Project
//
//  Created by V, Giriprasath (Contractor) on 08/06/23.
//

import UIKit

struct currencyRates: Decodable{
    let base_code: String
    let conversion_rates: [String: Double]
}

class CurrencyRatesViewController: UIViewController {
    
    @IBOutlet weak var currencyTF: UITextField!
    
    
    @IBOutlet weak var conversionRatesTV: UITableView!
        
var usd: currencyRates?
        
var base_rate:Double  =  1.0

override func viewDidLoad() {
    super.viewDidLoad()
        
    conversionRatesTV.dataSource = self
                
    conversionRatesTV.allowsSelection = false
    conversionRatesTV.showsVerticalScrollIndicator = false
                
    fetchData()
        
}
    
@IBAction func convertB(_ sender: UIButton) {
    if let getString = currencyTF.text{
        if let isDouble = Double(getString){
            base_rate = isDouble
            fetchData()
        }
    }
}
    
func fetchData(){
    let url = URL(string: "https://v6.exchangerate-api.com/v6/6de0bead0f3ec79f4dfa75df/latest/USD")
              
    URLSession.shared.dataTask(with: url!){ (data, response, error) in
        if error == nil{
            do{
                self.usd = try JSONDecoder().decode(currencyRates.self, from: data!)
            } catch{
                    print("Parse error")
            }
            DispatchQueue.main.async {
                self.conversionRatesTV.reloadData()
            }
        }
        else{
            print("error")
        }
    }.resume()
}
      
  }

extension CurrencyRatesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currencyFetched = usd{
            return currencyFetched.conversion_rates.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        if let currencyFetched = usd{
            cell.textLabel?.text = Array(currencyFetched.conversion_rates.keys)[indexPath.row]
            let selectedRate = base_rate *  Array(currencyFetched.conversion_rates.values)[indexPath.row]
            cell.detailTextLabel?.text = "\(selectedRate)"
            return cell
        }
        return UITableViewCell()
    }
}
