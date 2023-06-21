//
//  Utility.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 12/06/23.
//

import Foundation
import UIKit
import CoreData

struct Utility{
    static var shared = Utility()
    let dbContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init(){
    }
    func addData(amount: String, fromcount: String, toCount: String, conAmt: String, conRate: String){
        let data = CurrencyConv(context: dbContext)
        data.amount = amount
        data.fromCoun = fromcount
        data.toCoun = toCount
        data.cAmt = conAmt
        data.cRate = conRate
        
        do{
            try dbContext.save()
            print("datas added..\(amount)")
        }catch{
            print("data not added: \(error.localizedDescription)")
        }
        
    }
    func del(data: CurrencyConv){
        dbContext.delete(data)
        do{
            try dbContext.save()
            print("datas deleted: \(data.amount ?? "")")
        }
        catch{
            print("data not deleted: \(error.localizedDescription)")
        }
    }
    func getAllData() -> [CurrencyConv]{
        let dataReq = CurrencyConv.fetchRequest()
        do{
            let result = try dbContext.fetch(dataReq)
           return result
        }
        catch{
            return []
        }
        
    }
}
