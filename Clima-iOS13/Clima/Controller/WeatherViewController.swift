//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    // Связь с элементами пользовательского интерфейса
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchField: UITextField!
    
    var weatherManager = WeatherManager()

    override func viewDidLoad() {
            super.viewDidLoad()
            // Устанавливаем делегата для текстового поля
            searchField.delegate = self
            
            // Создаем UITapGestureRecognizer и привязываем его к методу dismissKeyboard
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            // Добавляем распознаватель жестов в основное представление
            view.addGestureRecognizer(tapGesture)
        }

        // Метод вызывается при нажатии кнопки поиска
        @IBAction func searchButton(_ sender: UIButton) {
            // Получаем текст из текстового поля
            _ = searchField.text ?? "None text"
            // Завершаем редактирование, скрывая клавиатуру
            searchField.endEditing(true)
            if let city = searchField.text, !city.isEmpty {
                    weatherManager.fetchWeather(cityName: city)
                }
            searchField.text = ""
        }

        // Метод делегата, вызывается при нажатии клавиши Return (GO) на клавиатуре
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Получаем текст из текстового поля
            _ = searchField.text ?? "None text"
            // Завершаем редактирование, скрывая клавиатуру
            searchField.endEditing(true)
            
            if let city = searchField.text, !city.isEmpty {
                    weatherManager.fetchWeather(cityName: city)
                }
            searchField.text = ""
                return true
        }

        // Метод делегата, вызывается после завершения редактирования текстового поля
        func textFieldDidEndEditing(_ textField: UITextField) {
//            if let city = searchField.text, !city.isEmpty{
//                weatherManager.fetchWeather(cityName: city)
//            }
            // Очищаем текстовое поле
            //searchField.text = ""
        }

        // Метод делегата, вызывается для определения, должно ли текстовое поле завершать редактирование
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            // Проверяем, не пустое ли текстовое поле
            if searchField.text != "" {
                return true
            } else {
                // Если текстовое поле пустое, показываем placeholder и не завершаем редактирование
                searchField.placeholder = "Type something"
                return true
            }
        }

        // Метод, вызываемый при касании экрана
        @objc func dismissKeyboard() {
            // Завершаем редактирование, скрывая клавиатуру
            view.endEditing(true)
        }
    
    }

