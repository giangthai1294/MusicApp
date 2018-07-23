//
//  LibraryViewController.swift
//  MusicApp
//
//  Created by Apple on 7/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // MARK : Properties
    var listMusicData = [MusicData]()
    @IBOutlet weak var tableView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier == "DetailMusicSegue" {
            let distination = segue.destination as! DetailMusicViewController
            let musicData = sender as! MusicData
            distination.data = musicData
            if musicData.type == MusicData.MusicType.LOCAL {
                    distination.musicType = DetailMusicViewController.MusicType.LOCAL
            } else {
                distination.musicType = DetailMusicViewController.MusicType.ONLINE
            }
        }
    }
    
    func loadData()  {
        for i in 1...9 {
            let data = MusicData()
            data.initMusicData(musicName: "A", singer: "AA", art: "AAA", imgAvatar: "Album_\(i)", linkUrl: "music", ext: "mp3", type : MusicData.MusicType.LOCAL)
            listMusicData.append(data)
        }
        self.tableView.reloadData()
    }
}

extension LibraryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.listMusicData.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 1
        
        return CGSize(width: width, height: 223)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let musicData = listMusicData[indexPath.row]
        self.performSegue(withIdentifier: "DetailMusicSegue", sender: musicData)
    }
}
