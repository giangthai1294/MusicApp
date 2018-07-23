//
//  ForYouViewController.swift
//  MusicApp
//
//  Created by Apple on 7/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ForYouViewController: UIViewController {
    
    @IBOutlet weak var midleCollectionView: UICollectionView!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForYouViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == midleCollectionView {
            return 2
        }
        
        if collectionView == bottomCollectionView {
            return 10
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == midleCollectionView {
           let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "midleCell", for: indexPath)
            return cell
        }
        
        if collectionView == bottomCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath)
            return cell
        }
        let cell = UICollectionViewCell()
        return cell
    }
    
    
}
