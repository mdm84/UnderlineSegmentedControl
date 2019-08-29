//
//  UnderlineSegmentedControl.swift
//
//  Created by Massimiliano DI MELLA on 29/08/2019.
//  Copyright © 2019 MDM. All rights reserved.
//

import UIKit

class UnderlineSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex: Int = 0
    
    @IBInspectable var buttonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    @IBInspectable var textColor : UIColor = .black {
        didSet {
            updateView()
        }
    }
    @IBInspectable var selectedTextColor : UIColor = .blue {
        didSet {
            updateView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("non implementata")
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { v in
            v.removeFromSuperview()
        }
        let titles = buttonTitles.components(separatedBy: ",")
        for title in titles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            // colore alternativo
        }
        buttons[0].setTitleColor(selectedTextColor, for: .normal)
        let selectorWidth = frame.width / CGFloat(titles.count)
        let y = frame.maxY - frame.minY - 3.0
        selector = UIView(frame: CGRect(x: 0, y: y, width: selectorWidth, height: 2))
        selector.layer.cornerRadius = 16
        selector.layer.masksToBounds = true
        selector.backgroundColor = selectedTextColor
        addSubview(selector)
        
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        
    }

    @objc func buttonTapped(_ sender: UIButton) {
        for (index, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                selectedSegmentIndex = index
                let position = btn.center.x
                UIView.animate(withDuration: 0.3) {
                    self.selector.center.x = position
                }
                btn.setTitleColor(selectedTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
    
    

}
