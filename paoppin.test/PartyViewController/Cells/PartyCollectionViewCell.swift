//
//  PartyCollectionViewCell.swift
//  paoppin.test
//
//  Created by khawaja fahad on 03/12/2023.
//

import UIKit

class PartyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelPartyBy: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelPerformers: UILabel!
    @IBOutlet weak var labelEntry: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    lazy var viewModel = {
        PartyCollectionViewCellViewModel()
    }()
    
    var cellViewModel: Party? {
        didSet {
            labelPartyBy.attributedText = viewModel.getTextForPartyBy()
            labelTitle.text = cellViewModel!.name
            labelDate.attributedText = viewModel.getTextForDate(dateOfParty: cellViewModel!.startDate )
            labelTime.attributedText = viewModel.getTextForTime(dateOfParty: cellViewModel!.startDate )
            labelPerformers.attributedText = viewModel.getTextForPerformers()
            labelEntry.attributedText = viewModel.getTextForEntry(amount: cellViewModel!.price)
            imageBackground.image = viewModel.getImageNameForBackgroundImage(imageURL: cellViewModel!.bannerImage)
        
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
