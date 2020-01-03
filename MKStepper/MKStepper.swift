//
//  MKStepper.swift
//  CustomStepper
//
//  Created by Seokho on 2020/01/03.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

public class MKStepper: UIControl {
    weak var minusButton: UIButton?
    weak var plusButton: UIButton?
    weak var label: UILabel?
    
    var maximumValue: Double = 10
    var minimumValue: Double = 0
    var labelOriginalX: CGFloat?
    
    var value: Double = 0.0 {
        didSet {
            value = min(maximumValue, max(minimumValue,value))
            self.label?.text = "\(value)"
            if oldValue != value {
                sendActions(for: .valueChanged)
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeViewLayout()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        
        if let label = self.label, let labelOriginalX = self.labelOriginalX {
            switch gesture.state {
            case .changed:
                let translation = gesture.translation(in: label)
                gesture.setTranslation(.zero, in: label)
                
                UIView.animate(withDuration: 0.1) {
                    if gesture.velocity(in: label).x > 0{
                        
                        if self.value != self.maximumValue {
                            self.minusButton?.backgroundColor = .systemPink
                            self.value += 1
                        } else {
                            self.plusButton?.backgroundColor = .systemGray6
                        }
                        
                        label.center.x = min(labelOriginalX + 10, label.center.x + translation.x)
                    } else if gesture.velocity(in: label).x < 0 {
                        if self.value != self.minimumValue {
                            self.plusButton?.backgroundColor = .systemPink
                            self.value -= 1
                        } else {
                            self.minusButton?.backgroundColor = .systemGray6
                        }
                        label.center.x = max(labelOriginalX - 10, label.center.x + translation.x)
                    }
                }
            case .ended:
                endButtonEvent()
            default:
                break
            }
        }
        
    }
    
    private func makeViewLayout() {
        let minusButton = makeStepperLabel("minus", .systemPink)
        minusButton.addTarget(self, action: #selector(decreaseValue(sender:)), for: .touchDown)
        minusButton.addTarget(self, action: #selector(endButtonEvent), for: .touchUpInside)
        self.minusButton = minusButton
        
        let label = UILabel()
        label.text = "\(value)"
        label.font = .boldSystemFont(ofSize: 28)
        label.backgroundColor = .systemGray6
        label.textColor = .systemPink
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panRecognizer.maximumNumberOfTouches = 1
        label.addGestureRecognizer(panRecognizer)
        self.label = label
        
        let plusButton =  makeStepperLabel("plus", .systemPink)
        plusButton.addTarget(self, action: #selector(increaseValue(sender:)), for: .touchDown)
        plusButton.addTarget(self, action: #selector(endButtonEvent), for: .touchUpInside)
        self.plusButton = plusButton
        
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(plusButton)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            minusButton.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.6),
            label.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.2),
            plusButton.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        
    }
    
    private func makeStepperLabel(_ title: String, _ backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: title), for: .normal)
        button.tintColor = .white
        button.backgroundColor = backgroundColor
        return button
    }
    
    @objc private func decreaseValue(sender: UIButton) {
        if self.value != minimumValue {
            UIView.animate(withDuration: 0.1) {
                self.label?.center.x -= 5
            }
            self.value -= 1
        } else {
            sender.backgroundColor = .systemGray6
        }
    }
    
    @objc private func increaseValue(sender: UIButton) {
        
        if self.value != maximumValue {
            UIView.animate(withDuration: 0.1) {
                self.label?.center.x += 5
            }
            self.value += 1
        } else {
            UIView.animate(withDuration: 0.1) {
                sender.backgroundColor = .systemGray6
            }
        }

    }
    
    @objc private func endButtonEvent() {
        if let labelOriginalX = self.labelOriginalX {
            UIView.animate(withDuration: 0.1) {
                self.label?.center.x = labelOriginalX
            }
            
            self.plusButton?.backgroundColor = .systemPink
            self.minusButton?.backgroundColor = .systemPink
        }
    }
    
    public override func layoutSubviews() {
        self.labelOriginalX = self.label?.center.x
    }
    
}

