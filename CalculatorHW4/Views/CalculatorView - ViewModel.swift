//
//  MainViewModel.swift
//  CalculatorHW4
//
//  Created by Korsun Yevhenii on 09.05.2022.
//

import UIKit

extension CalculatorView {
    struct ViewModel {
        let allButtonsName: [String] = ["AC", "(", "7", "8", "9", "*", "←", ")", "4", "5", "6", "-", "^", "e", "1", "2", "3", "+", "/", "π", "0", ".", "="]
        private let verticalButtonsStruct: [[String]] = [
            ["AC", "←", "^", "/"],
            ["7", "8", "9", "*"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["0", ".", "="],
        ]
        private let horizontalButtonsStruct: [[String]] = [
            ["AC", "(", "7", "8", "9", "*"],
            ["←", ")", "4", "5", "6", "-"],
            ["^", "e", "1", "2", "3", "+"],
            [ "/", "π", "0", ".", "="],
        ]
        let colorButtonsName: [String] = ["AC", "←", "^", "/", "*", "-", "+", "="]
        let clearButtonNames = ["AC", "C"]
        let bigButtonsName: [String] = ["0"]
        
        let spacer: CGFloat = CGFloat(Int(UIScreen.fixedSmallSize * 0.91 / 43))
        let tabBarHeight: CGFloat = 49.0
        
        func getButtonsStruct(basedOn orientation: ScreenOrientation) -> [[String]] {
            switch orientation {
            case .portrait: return verticalButtonsStruct
            case .landscape: return horizontalButtonsStruct
            }
        }
        
        func getButtonsHeight(basedOn orientation: ScreenOrientation) -> CGFloat {
            switch orientation {
            case .portrait: return spacer * 10
            case .landscape: return spacer * 6
            }
        }
        func getButtonsWidth(basedOn orientation: ScreenOrientation) -> CGFloat {
            let buttonCountInRow: CGFloat = CGFloat(getButtonsStruct(basedOn: orientation)[0].count)
            switch orientation {
            case .portrait:
                return spacer * 10
            case .landscape:
                return CGFloat((Int((UIScreen.fixedBigSize * 0.9 - ((buttonCountInRow - 1) * spacer)) / buttonCountInRow)))
            }
        }
        
        func getXOffset(basedOn orientation: ScreenOrientation) -> CGFloat {
            let buttonCountInRow: CGFloat = CGFloat(getButtonsStruct(basedOn: orientation)[0].count)
            let buttonWidth = getButtonsWidth(basedOn: orientation)
            switch orientation {
            case .portrait: return (UIScreen.fixedSmallSize - (buttonWidth * buttonCountInRow) - (spacer * (buttonCountInRow - 1))) / 2
            case .landscape: return (UIScreen.fixedBigSize - buttonWidth * buttonCountInRow - spacer * (buttonCountInRow - 1)) / 2
                
            }
        }
        func getYOffset(basedOn orientation: ScreenOrientation, bottomPadding: CGFloat) -> CGFloat {
            let rowCount: CGFloat = CGFloat(getButtonsStruct(basedOn: orientation).count)
            let buttonHeight = getButtonsHeight(basedOn: orientation)
            let sceneHeight: CGFloat = (buttonHeight * rowCount) + (spacer * (rowCount - 1))
            switch orientation {
            case .portrait: return UIScreen.height - sceneHeight - tabBarHeight - bottomPadding
            case .landscape: return UIScreen.fixedSmallSize - sceneHeight - tabBarHeight - bottomPadding
            }
        }
        
        func setButtonFont(basedOn orientation: ScreenOrientation) -> UIFont {
            switch orientation {
            case .portrait:  return UIFont.systemFont(ofSize: 30)
            case .landscape:  return UIFont.systemFont(ofSize: 24)
            }
        }
    }
}
