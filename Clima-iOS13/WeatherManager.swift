//
//  WeatherManager.swift
//  Clima
//
//  Created by Toporusan on 04.08.2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a3c49ffb43d234ff4b07827d683eb15e&units=metric"
    var delegate: WeatherManagerDelegate?

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
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data)-> WeatherModel? {
        let decoder = JSONDecoder()
        
        do{
           let decodedData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name 
            
            let weather = WeatherModel(conditionId: id, ityName: name, temperature: temp)
            return weather
            
        }catch{
            print(error)
            return nil
        }
    }
    
    
   
}
