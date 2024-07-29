//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
    }

    @IBAction func searchButton(_ sender: UIButton) {
        let searchText = searchField.text ?? "None text"
        searchField.endEditing(true)
        print(searchText)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let searchText = searchField.text ?? "None text"
        searchField.endEditing(true)
        print(searchText)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchField.text != ""{
            return true
        }else{
            searchField.placeholder = "Type something"
            return false
        }
    }
}
