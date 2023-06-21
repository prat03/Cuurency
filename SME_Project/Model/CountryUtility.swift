//
//  CountryUtility.swift
//  SME_Project
//
//  Created by V, Giriprasath (Contractor) on 13/06/23.
//

import Foundation

struct CountryDetails: Codable{
    let supported_codes: [[String]]
}


struct currencyutility{
    let apiKey = "6de0bead0f3ec79f4dfa75df"
    let tmbUrl = "https://v6.exchangerate-api.com/"
    
    
    static var shared = currencyutility()
    private init(){
        
    }
    
    func countries(handler: @escaping ([CountryDetails]) -> Void){
        let upcomingUrl = "\(tmbUrl)v6/\(apiKey)/codes"
        
        if let tmbnew = URL(string: upcomingUrl){
            let session = URLSession.shared
            
            let task = session.dataTask(with: tmbnew) { countrydata, resp, error in
                if error == nil{
                    if let sCode = (resp as? HTTPURLResponse)?.statusCode{
                        switch sCode{
                        case 200...299:
                            print("Success: \(tmbnew)")
                            let countryList = parseData(cData: countrydata)
                            handler(countryList)
                            
                        default:
                            print("Failed: \(sCode)")
                        }
                    }
             }
                else{
                    print("Network error")
                    
                }
                
            }
            task.resume()
        }
        else{
            print("invalid url")
        }
        

    }
    
    func parseData(cData: Data?) -> [CountryDetails]{
        guard let countrydata = cData else{
            print("data is not available")
            return []
        }
        print("Parse data")
        do{
            let CountryResult = try JSONDecoder().decode(CountryDetails.self, from: countrydata)
            print("Got: \(CountryResult.supported_codes.count)")
          
            return [CountryResult]
        }catch{
            print("Decoding error: \(error.localizedDescription)")
        }
        return []
    }
}

