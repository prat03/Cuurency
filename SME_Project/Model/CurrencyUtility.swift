//
//  CurrencyUtility.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 08/06/23.
//

import Foundation

struct CurrencyUtility {
    
    let apikey = "29b79ed48bf9639c1ee3fb4c"
    
    
    static var shared = CurrencyUtility()
    private init(){
        
    }
    
    func getConvertCurrency(){
        let url = "https://v6.exchangerate-api.com/v6/29b79ed48bf9639c1ee3fb4c/latest/EUR"
        
        if let tempUrl = URL(string: url){
            let session = URLSession.shared
            
            let task = session.dataTask(with: tempUrl) { convertdata, resp, err in
                if err == nil {
                    
                    if let sCode = (resp as? HTTPURLResponse)?.statusCode{
                        switch sCode {
                        case 200...299:
                            print("success \(sCode)")
                          //  parseData(convertdata)
                        default:
                            print("failed")
                        }
                        
                    }
                }
                    else{
                        print("request failed") //ALERT
                    }
                }
                task.resume()
            }
            else{
                print("invalid url")
            }
        }
    }

