//
//  DetailMusicViewController.swift
//  MusicApp
//
//  Created by Apple on 7/21/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import AVFoundation

class DetailMusicViewController: UIViewController {
    
    // MARK : Outlet
    @IBOutlet weak var sliderMusic: UISlider!
    @IBOutlet weak var lbEnd: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSinger: UILabel!
    @IBOutlet weak var slideVolume: UISlider!
    
    
    // MARK : Properties
    enum MusicType {
        case ONLINE, LOCAL, NONE
    }
    var onlinePlayer : AVPlayer?
    var localPlayer : AVAudioPlayer?
    var musicType : MusicType?
    var data : MusicData?
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        initPlayer()
        
    }
    
    func initPlayer() {
        if data == nil {
            return
        }
        
        if musicType == MusicType.LOCAL {
            guard let url = Bundle.main.url(forResource: data?.linkUrl, withExtension: data?.ext) else {
                return
            }
            do {
                localPlayer = try AVAudioPlayer(contentsOf: url)
                let duration = localPlayer?.duration
                let min = Int(duration!) / 60
                let second = Int(duration!) % 60
                self.lbEnd.text = "\(min):\(second)"
                self.sliderMusic.maximumValue = Float(duration!)
            } catch let err {
                print(err.localizedDescription)
            }
        }
        else if musicType == MusicType.ONLINE {
            let url = URL(string: (self.data!.linkUrl)!)
            onlinePlayer = AVPlayer(url: url!)
            guard let duration = onlinePlayer?.currentItem?.asset.duration else {
                return
            }
            let durationBySecond = CMTimeGetSeconds(duration)
            let min = Int(durationBySecond) / 60
            let second = Int(durationBySecond) % 60
            self.lbEnd.text = "\(min):\(second)"
            self.sliderMusic.maximumValue = Float(durationBySecond)
        }
        else {
            return
        }
    }
    
    @objc func updateSlider() {
        if localPlayer == nil && onlinePlayer == nil {
            return
        }
        
        if localPlayer!.isPlaying == true {
            sliderMusic.value = Float((localPlayer!.currentTime))
        } else if onlinePlayer != nil{
            let currentTimeBySecond = CMTimeGetSeconds((onlinePlayer!.currentTime()))
            sliderMusic.value = Float(currentTimeBySecond)
        }
    }
    
    // MARK : Action
    @IBAction func onClickBtnPlay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if localPlayer != nil {
            if localPlayer?.isPlaying == true {
                localPlayer?.stop()
            } else {
                localPlayer?.play()
            }
        } else if onlinePlayer != nil {
            if sender.isSelected == true {
                onlinePlayer?.play()
            } else {
                onlinePlayer?.pause()
            }
        }
    }
    @IBAction func onClickNextTime(_ sender: Any) {
        let currentTime = sliderMusic.value
        var targetTime : Float = 0
        if currentTime + 10 > sliderMusic.maximumValue {
            targetTime = sliderMusic.maximumValue
        } else {
            targetTime = currentTime + 10
        }
        
        sliderMusic.value = targetTime
        if localPlayer != nil {
            localPlayer?.currentTime = TimeInterval(targetTime)
        } else if onlinePlayer != nil {
            onlinePlayer?.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1))
        }
    }
    @IBAction func onClickBtnBackTime(_ sender: Any) {
      let currentTime = sliderMusic.value
        var targetTime : Float = 0
        if currentTime - 10 > 0 {
            targetTime = currentTime - 10
        } else {
         targetTime = 0
        }
        
        sliderMusic.value = targetTime
        if localPlayer != nil {
            localPlayer?.currentTime = TimeInterval(targetTime)
        } else if onlinePlayer != nil {
            onlinePlayer?.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1))
        }
    }
    
    @IBAction func onChangeSliderVolume(_ sender: Any) {
        if localPlayer != nil {
            localPlayer?.volume = slideVolume.value
        } else if onlinePlayer != nil {
            onlinePlayer?.volume = slideVolume.value
        }
    }
}
