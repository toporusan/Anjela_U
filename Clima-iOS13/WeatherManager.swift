//
//  WeatherManager.swift
//  Clima
//
//  Created by Toporusan on 04.08.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a3c49ffb43d234ff4b07827d683eb15e&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlStr: urlString)
        print(urlString)
    }

    func performRequest(urlStr: String) {
        // 1. Create URL
        if let url = URL(string: urlStr) {
            // 2. Create URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        
        do{
           let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }catch{
            print(error)
        }
    }
}
