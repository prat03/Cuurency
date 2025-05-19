//
//  CurrencyUtility.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 08/06/23.
//
import UIKit
import Foundation
import Network

    struct CountryInfo: Codable {
        var conversion_result: Double
        var conversion_rate: Double
    }
    
    struct ConversionUtility {
        
        
        static var shared = ConversionUtility()
        
        private init(){
            
        }
        
        func getConvertCurrency(amount: String, from: String, to: String, handler: @escaping (CountryInfo) -> Void){
            
            let webUrl = "https://v6.exchangerate-api.com/v6/29b79ed48bf9639c1ee3fb4c/pair/\(from)/\(to)/\(amount)"
            
            //Refernce of URL Session
            let session = URLSession.shared
            
            //create request
            if let url = URL(string: webUrl){
                
                
                //create task
                let task = session.dataTask(with: url) { convertdata, resp, err in
                    
                    if err == nil {
                        print("success: \(webUrl)")
                        if let sCode = (resp as? HTTPURLResponse)?.statusCode{
                            switch sCode {
                            case 200...299:
                                print("success \(sCode)")
                                let countryInfo = parseData(jsonResponse: convertdata)
                                handler(countryInfo!)
                                
                            default:
                                print("failed")
                                    showErrorAlert(title: "enter the country", msg: "network error"){
                                
                                    }
                            }
                            
                        }
                    }
                    else{
                        print("request failed")
                        
                        //self.showErrorAlert(title: "no network", msg: "network error"){
                        
                        // }
                        //ALERT
                    }
                }
                task.resume()
            }
            else{
                print("invalid url")
            }
        }
        
        
        func parseData(jsonResponse: Data?) -> CountryInfo? {
            guard let jResponse = jsonResponse else{
                return nil
            }
            do{
                let countryInfo = try JSONDecoder().decode(CountryInfo.self, from: jResponse)
                print("decoding done")
                return countryInfo
            }
            catch{
                print("parsing failed: \(error.localizedDescription)")
            }
            return nil
        }
        func showErrorAlert(title:String, msg: String, handler: @escaping () -> Void){
            
            let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertVC.addAction(okAction)
            
            //present(alertVC, animated: true)
        }
    }
    
    

