//
//  Date.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(date style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
    
    func toString(time style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = style
        return formatter.string(from: self)
    }
    
}

