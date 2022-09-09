//
//  UITableView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 09.09.2022.
//

import UIKit

extension UITableView {
    var totalRowsCount: Int {
        var rowCount = 0
        for index in 0...numberOfSections - 1 {
            rowCount += numberOfRows(inSection: index)
        }
        return rowCount
    }
    
    func numberOfRowsTo(indexPath: IndexPath) -> Int {
        guard indexPath.section < numberOfSections else {
            return totalRowsCount
        }
        var rowsCount = 0
        for section in 0...indexPath.section {
            if section == indexPath.section {
                rowsCount += numberOfRows(inSection: indexPath.section) - (indexPath.row + 1)
            } else {
                rowsCount += numberOfRows(inSection: section)
            }
        }
        return rowsCount
    }
    
    func numberOfRowsToEndFrom(indexPath: IndexPath) -> Int {
        return totalRowsCount - numberOfRowsTo(indexPath: indexPath)
    }
    
    func scrollToBottom(isAnimated:Bool = true) {
        let indexPath = IndexPath(
            row: numberOfRows(inSection:  numberOfSections-1) - 1,
            section: numberOfSections - 1)
        if hasRowAtIndexPath(indexPath: indexPath) {
            scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
        }
    }
    
    func scrollToTop(isAnimated:Bool = true) {
        let indexPath = IndexPath(row: 0, section: 0)
        if hasRowAtIndexPath(indexPath: indexPath) {
            scrollToRow(at: indexPath, at: .top, animated: isAnimated)
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }
    
}
