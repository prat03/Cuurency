//
//  CountryServerModel.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 14/06/23.
//

import Foundation
import UIKit
struct CountryServerUtility{
    static var shared = CountryServerUtility()
    let dBContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init(){
    }
    
    func addCountryCode(country: String, code: String){
        let data = CountryCodes(context: dBContext)
        data.countries = country
        data.code = code
        
        do{
            try dBContext.save()
            print("datas added..\(country)")
        }catch{
            print("data not added: \(error.localizedDescription)")
        }
        
    }
    func getAllData() -> [CountryCodes]{
        let dataReq = CountryCodes.fetchRequest()
        do{
            let result = try dBContext.fetch(dataReq)
           return result
        }
        catch{
            return []
        }
        
    }
}
