//
//  weathernewViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2022/1/3.
//

import UIKit

class weathernewViewController: UIViewController {
    
    @IBOutlet var city: UILabel!
    @IBOutlet var temperature: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var summary: UILabel!
    
    var scenes = Scene()
    
    private let API_URL = "https://api.openweathermap.org/data/2.5/weather?"
    private let API_KEY = "fbd614e6fa98e66a409f737c82d191d8"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gotForecast(location: scenes.city)
    }
    

    func gotForecast(location: String) {
        
        guard let accessURL = URL(string: API_URL + "q=\(location)&units=metric&lang=zh_tw&appid=\(API_KEY)") else { return }
        
        let request = URLRequest(url: accessURL)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            //parse data
            if let data = data {
                let decoder = JSONDecoder()
                if let weatherData = try? decoder.decode(WeatherForecastData.self, from: data) {
                    print("============== Weather Full data ==============")
                    print(weatherData)
                    print("============== Weather Partial data ==============")
                    print("City: \(weatherData.name)")
                    print("Coordinate: (\(weatherData.coord.lon),\(weatherData.coord.lat))")
                    print("Temperature: \(weatherData.main.temp)°C")
                    print("Descrition: \(weatherData.weather[0].description)")
                    OperationQueue.main.addOperation {
                        self.city.text = weatherData.name
                        self.temperature.text = "Temperature: \(weatherData.main.temp)°C"
                        self.humidity.text = "Humidity: \(weatherData.main.humidity)%"
                        self.summary.text = weatherData.weather[0].description
                    }
                }
            }
        })
        
        task.resume()
        
    }

}
