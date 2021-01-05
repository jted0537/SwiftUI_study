//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 정동혁 on 2021/01/05.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var player: AVAudioPlayer!
    var timer: Timer!
    
    func initializePlayer() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "happyTown") else {
            print("음원 파일 에셋을 가져올 수 없습니다")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error  as NSError {
            print("플레이어 초기화 실패")
            print("코드: \(error.code), 메세지: \(error.localizedDescription)")
        }
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
    
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time/60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1)*100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        self.timeLabel.text = timeText
    }
    
    func makeAndFireTimer(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            if self.progressSlider.isTracking{ return }
            self.updateTimeLabelText(time:  self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
            
        })
        self.timer.fire()
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializePlayer()
        // Do any additional setup after loading the view.
    }
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            self.player?.play()
        } else{
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        }
        else {
            self.invalidateTimer()
        }
    }
    
    @IBAction func silderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking{return}
        self.player.currentTime = TimeInterval(sender.value)
    }
    
}

