//
//  WeatherStationCallout.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import UIKit

class WeatherStationCallout: UIView {
    
    private lazy var tempImageView: UIImageView = {
        let image = UIImage(systemName: "thermometer.medium")
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var windSpeedImageView: UIImageView = {
        let image = UIImage(systemName: "wind")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var windDirectionImageView: UIImageView = {
        let image = UIImage(systemName: "wind")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var precipImageView: UIImageView = {
        let image = UIImage(systemName: "cloud.rain.fill")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var temp: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        if let temp = weatherStation.temperature?.rounded() {
            label.text = "\(Measurement(value: temp, unit: UnitTemperature.fahrenheit))"
        }
        
        return label
    }()
    
    private lazy var windSpeed: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        if let windSpeed = weatherStation.windSpeed?.rounded() {
            label.text = "\(Measurement(value: windSpeed, unit: UnitSpeed.milesPerHour))"
        }
        
        return label
    }()
    
    private lazy var windDirection: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        if let windDirection = weatherStation.windDirection {
            label.text = "\(windDirection)"
        }
        
        return label
    }()
    
    private lazy var windIndicatorImageView: UIImageView = {
        let image = UIImage(systemName: "arrow.right")
        
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        let cardinalRotation = 90.deg2rad() // Rotation adjustment to match 0 degrees to North
        imageView.transform = imageView.transform.rotated(by: cardinalRotation)
        imageView.transform = imageView.transform.rotated(by: (weatherStation.windDirection ?? 0).deg2rad())
        
        return imageView
    }()
    
    private lazy var chanceOfPrecip: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(weatherStation.chanceOfPrecipitation.formatted(.percent))"
        
        return label
    }()
    
    private lazy var dataStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageStackView, dataStackView])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 32
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    let weatherStation: WeatherStation
    
    init(weatherStation: WeatherStation) {
        self.weatherStation = weatherStation
        
        super.init(frame: .zero)
        setupView()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        if weatherStation.temperature != nil {
            dataStackView.addArrangedSubview(temp)
            imageStackView.addArrangedSubview(tempImageView)
        }
        
        if weatherStation.windSpeed != nil {
            dataStackView.addArrangedSubview(self.windSpeed)
            imageStackView.addArrangedSubview(windSpeedImageView)
        }
        
        if weatherStation.windDirection != nil {
            dataStackView.addArrangedSubview(windIndicatorImageView)
            imageStackView.addArrangedSubview(windDirectionImageView)
        }
        
        dataStackView.addArrangedSubview(chanceOfPrecip)
        imageStackView.addArrangedSubview(precipImageView)
        
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            horizontalStackView.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 4),
            horizontalStackView.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 4),
            horizontalStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 4),
            horizontalStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 4)
        ])
    }
}
