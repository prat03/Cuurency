//
//  ViewController.swift
//  Coinage_Currency
//
//  Created by Leena, Jayakumar (Contractor) on 07/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbl: UITableView!
    
    
    @IBOutlet weak var country: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func searchB(_ sender: Any) {
        print("button")
        let country = country.text ?? ""
        Utility.shared.getCountry(country: country)
        print("abcd")
        print("asdfgh")
    }
}

