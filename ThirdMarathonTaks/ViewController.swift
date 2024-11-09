//
//  ViewController.swift
//  ThirdMarathonTaks
//
//  Created by Rishat Zakirov on 08.11.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDidEndSliding), for: [.touchUpInside, .touchUpOutside])
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    

    @objc private func sliderValueChanged(_ sender: UISlider) {
        updateViewPosition(progress: CGFloat(sender.value))
    }
    

    @objc private func sliderDidEndSliding(_ sender: UISlider) {
        let finalValue: Float = sender.value > 0.5 ? 1.0 : 0.0
        UIView.animate(withDuration: 0.5, animations: {
            sender.setValue(finalValue, animated: true)
            self.updateViewPosition(progress: CGFloat(finalValue))
        })
    }


    private func updateViewPosition(progress: CGFloat) {
        let startX = view.layoutMarginsGuide.layoutFrame.minX
        let endX = view.layoutMarginsGuide.layoutFrame.maxX - 100 * 1.5
        

        let positionX = startX + (endX - startX) * progress
        let rotationAngle = CGFloat.pi / 2 * progress
        let scale = 1 + 0.5 * progress

        squareView.transform = CGAffineTransform(translationX: positionX - startX, y: 0)
            .rotated(by: rotationAngle)
            .scaledBy(x: scale, y: scale)
    }
    

}


extension ViewController {
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(squareView)
        view.addSubview(slider)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            slider.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            //slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
