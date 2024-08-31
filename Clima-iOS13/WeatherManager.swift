//
//  WeatherManager.swift
//  Clima
//
//  Created by Toporusan on 04.08.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a3c49ffb43d234ff4b07827d683eb15e&units=metric"
    var delegate: WeatherManagerDelegate?


    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlStr: urlString)
    }
    
    func fetchWeather(latitude:CLLocationDegrees , longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlStr: urlString)
    }

    func performRequest(urlStr: String) {
        // 1. Create URL
        if let url = URL(string: urlStr) {
            // 2. Create URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session task
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }

    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()

        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name

            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather

        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
