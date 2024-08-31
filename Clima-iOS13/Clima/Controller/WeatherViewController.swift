//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {
    // Связь с элементами пользовательского интерфейса
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchField: UITextField!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // работа с GPS
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() // запускает работу GPS навигации

        // Устанавливаем делегата для текстового поля
        searchField.delegate = self
        weatherManager.delegate = self

        // Создаем UITapGestureRecognizer и привязываем его к методу dismissKeyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // Добавляем распознаватель жестов в основное представление
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func locationPresed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    // Метод вызывается при нажатии кнопки поиска
    @IBAction func searchPressed(_ sender: UIButton) {
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
        // searchField.text = ""
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

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation() // останавливает работу GPS навигации
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude:lat , longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
