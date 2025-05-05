//
//  ContentView.swift
//  weather
//
//  Created by Benjamin Rojo on 02/05/25.
//

import SwiftUI

struct WeatherMainView: View {
    var currentWeather = "sunny" // Change the wheater

    // Type of wheater
    var backgroundGradient: [Color] {
        switch currentWeather {
        case "sunny":
            return [.blue, .yellow]
        case "cloudy":
            return [.gray, .white]
        case "rainy":
            return [.blue.opacity(0.5), .gray]
        case "night":
            return [.black, .gray]
        default:
            return [.blue, .white]
        }
    }

    // SF Symbol of the wheater
    var weatherIcon: String {
        switch currentWeather {
        case "sunny":
            return "sun.max.fill"
        case "cloudy":
            return "cloud.fill"
        case "rainy":
            return "cloud.rain.fill"
        case "night":
            return "moon.stars.fill"
        default:
            return "questionmark"
        }
    }

    // SF Symbols with the type of the color
    var iconColor: Color {
        switch currentWeather {
        case "sunny":
            return .yellow
        case "cloudy":
            return .gray
        case "rainy":
            return .blue
        case "night":
            return .white
        default:
            return .white
        }
    }
    var body: some View {
        ZStack {
            // Dynamic background
            LinearGradient(
                gradient: Gradient(colors: backgroundGradient),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
//This is the scroll that will scroll all the elements small boxes(text and icons) and box boxes (7 hours and 7 days)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    Text("Swift City")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Text("25°")
                        .font(.system(size: 80))
                        .bold()
                        .foregroundColor(.white)

                    Image(systemName: weatherIcon)
                        .font(.system(size: 50))
                        .foregroundColor(iconColor)

                    Button(action: {
                        print("View Details tapped!")
                    }) {
                        Label("View Details", systemImage: "arrow.right")
                            .padding()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
//This are the views of the next 7 days and 7 hours and the air quality
                    WeatherDetailView()
                    WeeklyForecastView()
                    AirQualityView()
                    WindMapView()
                    Spacer(minLength: 20)
                }
                .padding()
            }
        }
    }
}

// The weather in the next 7 hours
struct WeatherDetailView: View {
    var body: some View {
        VStack(alignment: .center) {
                    Text("Hourly Forecast")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom)
// hours,icons and temperatures we extract the value from the arrays that are in the bottom
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<7) { index in
                                VStack(spacing: 10) {
                                    Text(hours[index])// we said index becasue we are in the loop 0 < 7 se the index means that we each since 0 to 7
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Image(systemName: icons[index])
                                        .renderingMode(.original)                                      .font(.title)

                                    Text("\(temperatures[index])°")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                }
                                .padding()
                                
                                .cornerRadius(12)
                            }
                        }
                        .padding(.horizontal)
                    }
                  

                    Spacer()
                }
              
            }
// This are the arrays that we using in the top
            let hours = ["Now", "12 P.M.", "1 P.M.", "2 P.M.", "3 P.M.", "4 P.M.", "5 P.M."]
            let icons = ["sun.max.fill", "sun.max.fill", "cloud.sun.fill", "cloud.fill", "cloud.fill", "cloud.rain.fill", "cloud.bolt.rain.fill"]
            let temperatures = [25, 26, 27, 28, 28, 27, 26]

    }

//Struct of the next 7 days
struct ForecastDay: Identifiable {
    let id = UUID()
    let day: String
    let icon: String
    let maxTemp: Int
    let minTemp: Int
}
let weeklyForecast = [
    ForecastDay(day: "Monday", icon: "sun.max.fill", maxTemp: 25, minTemp: 15),
    ForecastDay(day: "Tuesday", icon: "cloud.rain.fill", maxTemp: 21, minTemp: 13),
    ForecastDay(day: "Wednesday", icon: "cloud.sun.fill", maxTemp: 23, minTemp: 14),
    ForecastDay(day: "Thursday", icon: "cloud.fill", maxTemp: 22, minTemp: 12),
    ForecastDay(day: "Friday", icon: "cloud.bolt.rain.fill", maxTemp: 19, minTemp: 11),
    ForecastDay(day: "Saturday", icon: "sun.max.fill", maxTemp: 27, minTemp: 16),
    ForecastDay(day: "Sunday", icon: "cloud.sun.fill", maxTemp: 24, minTemp: 14)
]
struct WeeklyForecastView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("7 Day Forecast")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
//this are the array of the weeklyForecast and apper one by one( day, icon, maxtemp, mintemp)
            ForEach(weeklyForecast) { day in
                HStack {
                    Text(day.day)
                        .frame(width: 200, alignment: .leading)
                        .foregroundColor(.white)
                        .font(.headline)

                    Image(systemName: day.icon)
                        .renderingMode(.original)
                        .font(.headline)

                    Spacer()

                    Text("\(day.maxTemp)° / \(day.minTemp)°")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.0))
                .cornerRadius(12)
            }
        }
        .padding(.top)
    }
}

//This is the air quality
struct AirQualityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AIR QUALITY")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
                .textCase(.uppercase)
                .padding(.top)
            Text("Acceptable")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
// This is the linea
            ZStack(alignment: .leading) {
                LinearGradient(
                    gradient: Gradient(colors: [.green, .yellow, .orange, .red, .purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 5.9)
                .cornerRadius(6)

            //This is the circle of the line
                Circle()
                    .fill(Color.white)
                    .frame(width: 12, height: 12)
                    .offset(x: 50)
            }

            Text("Air quality is better than yesterday at about this time.")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.white.opacity(0.0))
        .cornerRadius(20)
    }
}

//This is wind map image
struct WindMapView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("WIND MAP")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .textCase(.uppercase)
            Image("Air")
                .resizable()
                .scaledToFit()
                .cornerRadius(40)

          
        }
        .padding()
        .background(Color.white.opacity(0.0))
        .cornerRadius(20)

    }
}

#Preview {
    WeatherMainView()
}
