//
//  Utility.swift
//  Coinage_Currency
//
//  Created by Leena, Jayakumar (Contractor) on 07/06/23.
//

import Foundation

struct Info:Codable{
    var USDEUR: Double
    var USDGBP: Double
}
struct CountryList: Codable{
    var conversion_rates: [Info]
}

struct Utility {
    static let shared = Utility()
    
    private init(){
        
    }
    func getCountry(country: String){
        
        let webservicelink = "https://v6.exchangerate-api.com/v6/cf9c59cee7688ee360c5758d/latest/USD"
        
        let session = URLSession.shared
        
        if let url = URL(string: webservicelink){
            let task = session.dataTask(with: url){ respdata, httpResp, err in
                if err == nil {
                    print("success: \(webservicelink)")
                    
                    let statusCode = (httpResp as! HTTPURLResponse).statusCode
                    
                    switch statusCode {
                    case 200...299:
                        print("success")
                        parseData(jsonResponse: respdata)
                    case 300...399:
                    print("redirection")
                      case 400...499:
                        print("client error")
                     case 500...599:
                          print("server error")
                     default:
                    print("unknown error")
                    }
                    
                }
                else{
                    print("rew not compleyed")
                    
                }
                }
            task.resume()
            
        }
        else{
            print("invalid url")
        }
    }
    func parseData(jsonResponse: Data?){
        
        guard let jResponse = jsonResponse else {
            return
        }
        do{
            let CountryList = try JSONDecoder().decode(CountryList.self, from: jResponse)
            print("json decoding to be dome")
            return //CountryList.quotes
        }catch{
            print("parsing failed")
            print("project")
        }
    }
}
