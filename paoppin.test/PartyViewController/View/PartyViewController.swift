//
//  PartyViewController.swift
//  paoppin.test
//
//  Created by khawaja fahad on 03/12/2023.
//

import UIKit

class PartyViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var CELL_WIDTH = 300.0
    var CELL_HEIGHT = 475.0
    var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = CGSize(width: CGFloat(CELL_WIDTH), height: CGFloat(CELL_HEIGHT))
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    lazy var viewModel = {
        PartyViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        
        viewModel.loadPartiesForFirstLaunch()
        
        viewModel.reloadCollectionView = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.collectionView.reloadData()
       }
        }

    }
    
    
    @IBAction func actionAddParty(_ sender: Any) {
        viewModel.addPartyToList()
    }
    
}

extension PartyViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setUpCollectionViewlayout()
        registerNibForCollectionView()
    }
    
    func setUpCollectionViewlayout() {
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize = CGSize(width: CGFloat(300), height: CGFloat(475))
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
    }
    
    func registerNibForCollectionView() {
            
        self.collectionView.register(PartyCollectionViewCell.nib, forCellWithReuseIdentifier: PartyCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.parties.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.collectionView?.collectionViewLayout.invalidateLayout()
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PartyCollectionViewCell.identifier, for: indexPath) as? PartyCollectionViewCell else { return UICollectionViewCell() }
        cell.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        
         return cell
    }
    
}
