//
//  ContentView.swift
//  weather
//
//  Created by Benjamin Rojo on 02/05/25.
//

import SwiftUI

struct WeatherMainView: View {
    var currentWeather = "night" // Change the wheater

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
// The main text
            VStack(spacing: 16) {
                Text("Swift City")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("25°")
                    .font(.system(size: 80))
                    .bold()
                    .foregroundColor(.white)
                //SF Symbols with the color
                Image(systemName: weatherIcon)
                    .font(.system(size: 50))
                    .foregroundColor(iconColor)
// The first button
                Button(action: {
                    print("View Details tapped!")
                }) {
                    Label("View Details", systemImage: "arrow.right")
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
                WeatherDetailView()
            }
            .padding()
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

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(0..<7) { index in
                                VStack(spacing: 10) {
                                    Text(hours[index])
                                        .font(.headline)
                                        .foregroundColor(.white)

                                    Image(systemName: icons[index])
                                        .foregroundColor(.yellow)
                                        .font(.title)

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
                    .padding(.bottom)

                    Spacer()
                }
                .padding()
            }

            let hours = ["Now", "12 P.M.", "1 P.M.", "2 P.M.", "3 P.M.", "4 P.M.", "5 P.M."]
            let icons = ["sun.max.fill", "sun.max.fill", "cloud.sun.fill", "cloud.fill", "cloud.fill", "cloud.rain.fill", "cloud.bolt.rain.fill"]
            let temperatures = [25, 26, 27, 28, 28, 27, 26]
        
    }



#Preview {
    WeatherMainView()
}
