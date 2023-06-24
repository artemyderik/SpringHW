//
//  ViewController.swift
//  SpringHW
//
//  Created by Артемий Дериглазов on 23.06.2023.
//

import UIKit
import SpringAnimation

class ViewController: UIViewController  {

    //MARK: Private properties
    let animations = DataStore.shared.animations
    let curves = DataStore.shared.curves
    
    private var randomAnimation = ""
    private var randomCurve = ""
    private var randomForce = 0.0
    private var randomDuration = 0.0
    private var randomDelay = 0.0
    
    private var isAnimationSetuped = true
    
    //MARK: Outlets
    let presetView = SpringView()
    let presetLabel = SpringLabel()
    let runButton = SpringButton(type: .system)
    
    //MARK: Private methods of Randomization
    private func getRandomization() {
        getRandomAnimation()
        getRandomCurve()
        getRandomForce()
        getRandomDuration()
        getRandomDelay()
    }
    
    private func getRandomAnimation() {
        randomAnimation = animations[Int.random(in: 0..<animations.count)]
    }
    
    private func getRandomCurve() {
        randomCurve = curves[Int.random(in: 0..<curves.count)]
    }
    
    private func getRandomForce() {
        randomForce = getRandomCGFloat()
    }
    
    private func getRandomDuration() {
        randomDuration = getRandomCGFloat()
    }
    
    private func getRandomDelay() {
        randomDelay = getRandomCGFloat()
    }
    
    private func getRandomCGFloat() -> CGFloat {
        (Double.random(in: 0.5...2) * 100).rounded() / 100
    }

    //MARK: Private Methods of Setup
    private func setupViews() {
        view.addSubview(presetView)
        view.addSubview(runButton)
        
        setupView()
        setupLabel()
        setupButton()
    }

    private func setupView() {
        presetView.addSubview(presetLabel)
        
        presetView.backgroundColor = .gray
        presetView.clipsToBounds = true
        presetView.layer.cornerRadius = 18
        
        presetView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            presetView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            presetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            presetView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            presetView.heightAnchor.constraint(equalTo: presetLabel.heightAnchor, constant: 20)
        ])
    }
    
    private func setupLabel() {
        presetLabel.numberOfLines = 0
        presetLabel.text = "preset: \(randomAnimation)  \ncurve: \(randomCurve)  \nforce: \(randomForce) \nduration: \(randomDuration) \ndelay: \(randomDelay)"
        presetLabel.textColor = .white
        
        presetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            presetLabel.leftAnchor.constraint(equalTo: presetView.leftAnchor, constant: 10),
            presetLabel.centerYAnchor.constraint(equalTo: presetView.centerYAnchor)
        ])
    }
    
    private func setupButton() {
        runButton.setTitle("Run \(randomAnimation)", for: .normal)
        runButton.translatesAutoresizingMaskIntoConstraints = false
        runButton.backgroundColor = .gray
        runButton.tintColor = .white
        runButton.layer.cornerRadius = 8
        
        runButton.addTarget(self, action: #selector(runButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            runButton.centerXAnchor.constraint(equalTo: presetView.centerXAnchor),
            runButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            runButton.widthAnchor.constraint(equalTo: presetView.widthAnchor)
        ])
    }
        
    //MARK: OBJC Methods
    @objc func runButtonTapped() {
        if isAnimationSetuped {
            presetView.animation = randomAnimation
            presetView.curve = randomCurve
            presetView.force = randomForce
            presetView.duration = randomDuration
            presetView.delay = randomDelay
            presetView.animate()
            
            runButton.setTitle("Next animation", for: .normal)
            
            isAnimationSetuped.toggle()
        }
        
        else {
            getRandomization()
            setupLabel()
            runButton.setTitle("Run \(randomAnimation)", for: .normal)
            
            isAnimationSetuped.toggle()
        }
    }
    
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomization()
        setupViews()
    }
    
}


