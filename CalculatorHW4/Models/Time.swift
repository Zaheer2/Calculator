//
//  Time.swift
//  CalculatorHW4
//
//  Created by Fantom on 22.02.2022.
//

import UIKit

enum Time {
    
    case seconds
    case minutes
    case hours
    
    func getTime() -> Int {
        
        let date = Date()
        let calendar = Calendar.current
        
        switch self {
        case .seconds: return calendar.component(.second, from: date)
        case .minutes: return calendar.component(.minute, from: date)
        case .hours: return calendar.component(.hour, from: date)
        }
    }
    
    func getAngle() -> CGFloat {
        
        let secondAndMinuteTimeDevider: CGFloat = 60
        let hourTimeDevider: CGFloat = 12
        let circleAngle = 2 * CGFloat.pi
        
        let seconds = self.getSeconds()
        let minutes = self.getMinutes()
        
        switch self {
        case .seconds: return CGFloat(self.getTime()) * (circleAngle / secondAndMinuteTimeDevider)
        case .minutes: return (CGFloat(self.getTime()) + seconds / secondAndMinuteTimeDevider) * (circleAngle / secondAndMinuteTimeDevider)
        case .hours: return (CGFloat(self.getTime()) + minutes / secondAndMinuteTimeDevider) * (circleAngle / hourTimeDevider)
        }
    }
      
    private func getMinutes() -> CGFloat {
        let date = Date()
        let calendar = Calendar.current
        return CGFloat(calendar.component(.minute, from: date))
    }
    
    private func getSeconds() -> CGFloat {
        let date = Date()
        let calendar = Calendar.current
        return CGFloat(calendar.component(.second, from: date))
    }
}
