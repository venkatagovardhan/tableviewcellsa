//
//  SuccessViewModel.swift
//  success-demo
//
//  Created by Mahesh Dhumpeti on 04/01/22.
//

import UIKit

class SuccessViewModel {
    var cards: [CardVO] = []
    
    func numberOfRows() -> Int {
        return cards.count
    }
    
    func getCard(for indexPath: IndexPath) -> CardVO? {
        if indexPath.row < cards.count {
            return cards[indexPath.row]
        }
        return nil
    }
    
    func getCorners(for row: Int) -> CACornerMask {
        if row == 0 {
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if row == cards.count - 1 {
            return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        return []
    }
}
