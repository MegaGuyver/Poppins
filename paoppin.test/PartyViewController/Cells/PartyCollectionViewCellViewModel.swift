//
//  PartyCollectionViewCellViewModel.swift
//  paoppin.test
//
//  Created by khawaja fahad on 03/12/2023.
//

import Foundation
import UIKit

class PartyCollectionViewCellViewModel {
    
    var listDJs = [String.random(length: 5).uppercased(), String.random(length: 4).uppercased(), String.random(length: 6).uppercased()]
    
    func getTextForPartyBy() -> NSAttributedString {
        var club = String.random(length: 5) + " CLUB"
        club = club.uppercased()
        
        return String(format: "YOUR %@ PRESENTS", club).getAttributedText(stringToUpdateFont: club, font: UIFont.systemFont(ofSize: 10, weight: .light), updatedFont: UIFont.systemFont(ofSize: 10, weight: .medium))
    }
    
    func getTextForDate(dateOfParty: Date) -> NSAttributedString {
        let dateString = dateOfParty.toString(dateFormat: "EEEE, MMM d")
        
        return dateString.getAttributedTextForMultipleStrings(stringsToUpdateFont: [dateOfParty.toString(dateFormat: "EEEE"), dateOfParty.toString(dateFormat: "d")], font: UIFont.systemFont(ofSize: 30, weight: .light), updatedFont: UIFont.systemFont(ofSize: 30, weight: .medium))
        
    }
    
    func getTextForTime(dateOfParty: Date) -> NSAttributedString {
        let dateString = dateOfParty.toString(dateFormat: "h:mm a")
        
        return dateString.getAttributedText(stringToUpdateFont: dateOfParty.toString(dateFormat: "h:mm"), font: UIFont.systemFont(ofSize: 30, weight: .light), updatedFont: UIFont.systemFont(ofSize: 30, weight: .medium))
    }
    
    func getTextForPerformers() -> NSAttributedString {
        let perfomersString = String(format: "DJ %@   DJ %@   DJ %@", listDJs[0], listDJs[1], listDJs[2])
        return  perfomersString.getAttributedTextForMultipleStrings(stringsToUpdateFont: [listDJs[0], listDJs[1], listDJs[2]], font: UIFont.systemFont(ofSize: 16, weight: .light), updatedFont: UIFont.systemFont(ofSize: 16, weight: .medium))
 
    }
    
    func getTextForEntry(amount: Double) -> NSAttributedString {
        let amountString = String(amount)
        return String(format: "Entry $%@", amountString).getAttributedText(stringToUpdateFont: amountString, font: UIFont.systemFont(ofSize: 16, weight: .light), updatedFont: UIFont.systemFont(ofSize: 16, weight: .medium))
    }
    
    func getImageNameForBackgroundImage(imageURL: URL) -> UIImage? {
        let data = try? Data(contentsOf: imageURL)
        return UIImage(data: data!)
    }
    
}
