//
//  MusicData.swift
//  MusicApp
//
//  Created by Apple on 7/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MusicData {
    
    enum MusicType {
        case LOCAL, ONLINE, NONE
    }
    
    var musicName : String?
    var singer : String?
    var art :String?
    var imgAvatar : String?
    var linkUrl : String?
    var ext : String?
    var type : MusicType?
    
    func initMusicData(musicName : String, singer : String, art :String, imgAvatar : String, linkUrl : String, ext : String, type : MusicType)  {
        self.musicName = musicName
        self.singer = singer
        self.art = art
        self.imgAvatar = imgAvatar
        self.linkUrl = linkUrl
        self.ext = ext
        self.type = type
    }
}
