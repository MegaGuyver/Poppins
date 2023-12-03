//
//  PartyViewModel.swift
//  paoppin.test
//
//  Created by khawaja fahad on 03/12/2023.
//

import Foundation

class PartyViewModel {
    
    var reloadCollectionView: (() -> Void)?
    
    var parties =  [Party]() {
        didSet { reloadCollectionView?() }
    }
    
    let listOfNames = ["Beach Party", "Halloween Party", "NewYear Party", "Summer Party"]
    let listOfImages = ["one", "two", "three", "four"]
    
    func loadPartiesForFirstLaunch() {
        
        var tempParties = [Party]()
        
        for _ in 0...2 {
        
            tempParties.append(createNewPartyObject())
        }
        
        parties.append(contentsOf: tempParties)
    }
    
    func addPartyToList() {
        
        parties.append(createNewPartyObject())
    }
    
    func createNewPartyObject() -> Party {
        
        let partyObject: Party?
        
        
        let name = listOfNames.randomItem()!
        let bannerImage = getImageURLFromName(path: listOfImages.randomItem()!)!
        let price = Double.random(min: 4.99, max: 99.99).round(to: 2)
        let startDate = Date.getRandomDateWithinMonth()!
        let endDate = startDate.addingTimeInterval(Double.random(min: 46400, max: 86400))
        
        switch EndDateExistence.toss() {
        case .hasEndDate:
            partyObject = Party(name: name, bannerImage: bannerImage, price: price, startDate: startDate, endDate: endDate)
            
        case .noEndDate:
            partyObject = Party(name: listOfNames.randomItem()!, bannerImage: getImageURLFromName(path: listOfImages.randomItem()!)!, price: price, startDate: startDate)
            
        }
        
        return partyObject!
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> Party {
        
        return parties[indexPath.row]
    }
    
    func getImageURLFromName(path: String) -> URL? {
        
        guard let path = Bundle.main.path(forResource: listOfImages.randomElement(), ofType: "jpg") else {
            return nil
        }
        
        return URL(fileURLWithPath: path)
        
    }
    
}

