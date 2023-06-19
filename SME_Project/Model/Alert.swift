//
//  Alert.swift
//  SME_Project
//
//  Created by Leena, Jayakumar (Contractor) on 16/06/23.
//

import Foundation
import UIKit
extension TableViewController{
    func showErrorAlert(title:String, msg: String, handler: @escaping () -> Void){
        
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(okAction)
        
        present(alertVC, animated: true)
    }
}
