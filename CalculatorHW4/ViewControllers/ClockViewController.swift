//
//  ClockViewController.swift
//  CalculatorHW4
//
//  Created by Fantom on 21.02.2022.
//

import UIKit

class ClockViewController: UIViewController {
    
    private var lastSecond  = 0
    private var secondRotationAngle: CGFloat = 0
    private var minuteRotationAngle: CGFloat = 0
    private var hourRotationAngle: CGFloat = 0
    private var firstStart = true
    
    private lazy var clockCircle = CustomShadowsView()
    private lazy var smallCircle = CustomShadowsView()
    private lazy var secondsCircle = CustomShadowsView()
    private lazy var flipClock = CustomShadowsView()
    
    private lazy var secondsLabel = UILabel()
    private lazy var secondsArrow = UIView()
    private lazy var minuteArrow = UIView()
    private lazy var hourArrow = UIView()
    
    private lazy var numberViewArray: [CustomShadowsView] = []
    
    private lazy var timer: Timer = {
        let timer = Timer()
        
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .offWhite
        flipClock.backgroundColor = .offWhite
        setLabels()
        setClockObject()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clockCircle.setShadowsAndColor(color: .offWhite, cornerRadius: Constant.clockRadius)
        smallCircle.setShadowsAndColor(color: .offWhite, cornerRadius: Constant.smallCircleRadius)
    
        for element in numberViewArray {
            element.setShadowsAndColor(color: .offWhite, cornerRadius: Constant.flipClockCornerRadius)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] _ in
            guard let self = self else { return }

            let seconds = Time.seconds.getTime()
            let labelText = seconds % 5 == 0 ? "" : seconds < 10 ? String("0\(seconds)") : String(seconds)
            self.secondsLabel.text = labelText
            
            if self.lastSecond != seconds {
                let center = Constant.secondRadius
                let hOffset = self.getRoundOffset(timeToOffset: seconds, radius: Constant.secondRadius, ifVertical: false, time: Time.seconds)
                let vOffset = self.getRoundOffset(timeToOffset: seconds, radius: Constant.secondRadius, ifVertical: true, time: Time.seconds)
    
                self.secondsLabel.layer.opacity = 0
                
                UIView.animate(withDuration: 0.4) {
                    self.secondsLabel.center = CGPoint(x: center + vOffset, y: center - hOffset)
                    self.secondsArrow.transform = CGAffineTransform(rotationAngle: Time.seconds.getAngle())
                    self.minuteArrow.transform = CGAffineTransform(rotationAngle: Time.minutes.getAngle())
                    self.hourArrow.transform = CGAffineTransform(rotationAngle: Time.hours.getAngle())
                } completion: { _ in
                    UIView.animate(withDuration: 0.1) {
                        self.secondsLabel.layer.opacity = 1
                    }
                }
                self.lastSecond = seconds
            }
        }
    }
    
    func setLabels() {
        for number in 1...12 {
            let label = UILabel()
            let center = Constant.clockRadius - Constant.clockNumberWidht / 2
            let hOffset = self.getRoundOffset(timeToOffset: number, radius: Constant.secondRadius, ifVertical: false, time: .hours)
            let vOffset = self.getRoundOffset(timeToOffset: number, radius: Constant.secondRadius, ifVertical: true, time: .hours)
            
            label.frame = CGRect(x: center + vOffset, y: center - hOffset, width: Constant.clockNumberWidht, height: Constant.clockNumberWidht)
            label.text = String(number)
            label.textAlignment = .center
            label.textColor = .gray
            
            clockCircle.addSubview(label)
        }
        
        secondsLabel.frame.size = CGSize(width: Constant.clockNumberWidht, height: Constant.clockNumberWidht)
        secondsLabel.textAlignment = .center
        secondsLabel.textColor = .customPurple
        secondsLabel.font = UIFont.systemFont(ofSize: 12)
        secondsLabel.layer.opacity = 0
    }
    
    func setClockObject() {
        view.addSubview(clockCircle)
        
        clockCircle.addSubview(secondsCircle)
        clockCircle.translatesAutoresizingMaskIntoConstraints = false
        clockCircle.layer.cornerRadius = Constant.clockRadius
        
        NSLayoutConstraint.activate([
            clockCircle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            clockCircle.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            clockCircle.widthAnchor.constraint(equalToConstant: Constant.clockRadius * 2),
            clockCircle.heightAnchor.constraint(equalTo: clockCircle.widthAnchor),
        ])
        
        secondsCircle.addSubview(secondsLabel)
        secondsCircle.frame = CGRect(x: Constant.circleOffset , y: Constant.circleOffset, width: Constant.secondRadius, height: Constant.secondRadius)
        
        setElements(element: secondsArrow, frame: CGSize(width: Constant.secondArrowWidth, height: Constant.secondArrowHeight), color: .purple, cornerRadius: 5, isAnchor: true)
        
        setElements(element: minuteArrow, frame: CGSize(width: Constant.minuteArrowWidth, height: Constant.minuteArrowHeight), color: .gray, cornerRadius: 5, isAnchor: true)
        
        setElements(element: hourArrow, frame: CGSize(width: Constant.hourArrowWidth, height: Constant.hourArrowHeight), color: .darkGray, cornerRadius: 5, isAnchor: true)
        
        setElements(element: smallCircle, frame: CGSize(width: Constant.smallCircleDiametr, height: Constant.smallCircleDiametr), color: .offWhite, cornerRadius: Constant.smallCircleRadius, isAnchor: false)
        
        func setElements(element: UIView, frame: CGSize, color: UIColor, cornerRadius: CGFloat, isAnchor: Bool) {
            secondsCircle.addSubview(element)
            element.frame.size =  frame
            element.center = CGPoint(x: Constant.secondRadius, y: Constant.secondRadius)
            if isAnchor{
                element.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
            }
            element.backgroundColor = color
            element.layer.cornerRadius = cornerRadius
        }
    }
    
    func getRoundOffset(timeToOffset: Int, radius: CGFloat, ifVertical: Bool, time: Time) -> CGFloat {
        let secondAndMinuteTimeDevider: CGFloat = 60
        let hourTimeDevider: CGFloat = 12
        let circleLength = 2 * CGFloat.pi
        let secondsAndMinutesAngel: CGFloat = circleLength / secondAndMinuteTimeDevider
        let hoursAngel: CGFloat = circleLength / hourTimeDevider
    
        switch time {
        case .seconds: return ifVertical ? radius * sin(CGFloat(timeToOffset) * secondsAndMinutesAngel) : radius * cos(CGFloat(timeToOffset) * secondsAndMinutesAngel)
        case .minutes: return ifVertical ? radius * sin(CGFloat(timeToOffset) * secondsAndMinutesAngel) : radius * cos(CGFloat(timeToOffset) * secondsAndMinutesAngel)
        case .hours: return ifVertical ? radius * sin(CGFloat(timeToOffset) * hoursAngel) : radius * cos(CGFloat(timeToOffset) * hoursAngel)
        }
    }
}
