//
//  Helper.swift
//  paoppin.test
//
//  Created by khawaja fahad on 03/12/2023.
//

import Foundation
import UIKit

enum EndDateExistence: Int {
    case hasEndDate
    case noEndDate
    static func toss() -> EndDateExistence {
        return EndDateExistence(rawValue: Int(arc4random_uniform(2)))!
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func getAttributedText(stringToUpdateFont: String, font: UIFont, updatedFont: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: updatedFont]
        let range = (self as NSString).range(of: stringToUpdateFont, options: .caseInsensitive)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    
    func getAttributedTextForMultipleStrings(stringsToUpdateFont: [String], font: UIFont, updatedFont: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                     attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: updatedFont]
        for stringToUpdateFont in stringsToUpdateFont {
            let range = (self as NSString).range(of: stringToUpdateFont, options: .caseInsensitive)
            attributedString.addAttributes(boldFontAttribute, range: range)
        }
        return attributedString
    }

}

extension Date {
    
    static func getRandomDateWithinMonth() -> Date? {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let days = calendar.range(of: .day, in: .month, for: date),
            let randomDay = days.randomElement()
        else {
                return nil
        }
        dateComponents.setValue(randomDay, for: .day)
        dateComponents.setValue(Int.random(min: 18, max: 23), for: .hour)
        return calendar.date(from: dateComponents)
    }
}

extension Date {
    
    func adding(_ value: Int) -> Date? {
        var dayComponent    = DateComponents()
        dayComponent.day    = value
        dayComponent.hour   = Int.random(min: 18, max: 23)
        let theCalendar     = Calendar.current
        return  theCalendar.date(byAdding: dayComponent, to: self)
    }
}

public extension Double {

    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
}

public extension Int {

    static var random: Int {
        return Int.random(n: Int.max)
    }

    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }

    static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min

    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }
}
