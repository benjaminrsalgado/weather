//
//  ContentView.swift
//  weather
//
//  Created by Benjamin Rojo on 02/05/25.
//

import SwiftUI

struct WeatherMainView: View {
    var currentWeather = "rainy" // Change the wheater

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
                        .padding()                   .background(Color.white.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    WeatherMainView()
}
