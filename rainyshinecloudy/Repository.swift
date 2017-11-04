//
//  APIClient.swift
//  rainyshinecloudy
//
//  Created by robimolte on 03/11/2017.
//  Copyright © 2017 myself. All rights reserved.
//

import Foundation
import Alamofire

class Repository {
    
    var _currentWeather: CurrentWeather!
    var _forecastList = [Forecast]()
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherURL!).responseJSON {
            response in
            let result = response.result
            self._currentWeather = CurrentWeather()
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let name = dict["name"] as? String {
                    self._currentWeather._cityName = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._currentWeather._weatherType = main.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentWeather._currentTemp = Utility.kelvinToFareneith(temp: currentTemperature)
                    }
                }
            }
            completed()
        }
    }
    
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON {
            response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    for obj in list {
                        let forecast = Forecast()
                        if let temp = obj["main"] as? Dictionary<String, AnyObject> {
                            if let min = temp["temp_min"] as? Double {
                                forecast._lowTemp = "\(Utility.kelvinToFareneith(temp: min))"
                            }
                            if let max = temp["temp_max"] as? Double {
                                forecast._highTemp = "\(Utility.kelvinToFareneith(temp: max))"
                            }
                        }
                        if let weather = obj["weather"] as? [Dictionary<String,AnyObject>] {
                            if let main = weather[0]["main"] as? String {
                                forecast._weatherType = main
                            }
                        }
                        if let date = obj["dt"] as? Double {
                            let unixConverterDate = Date(timeIntervalSince1970: date)
                            forecast._date = Utility.dayOfTheWeek(unixConverterDate: unixConverterDate)
                        }
                    self._forecastList.append(forecast)
                    }
                }
                self._forecastList.remove(at: 0)
            }
            completed()
        }
    }
}

