//
//  ViewController.swift
//  Fish Version 1.1
//
//  Created by Viet Anh Doan on 6/21/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate  {
    
    var oceanAudio = AVAudioPlayer()
    var hookAudio = AVAudioPlayer()
    var hook = Hook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Timer.scheduledTimer(timeInterval: 1/24, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        view.addSubview(hook)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tapGesture)
        song()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTap(tapGesture: UITapGestureRecognizer) -> Void {
        if !hook.drop {
            let location = tapGesture.location(in: view)
            hook.center.x = location.x
            hook.drop = true
            hookAudio.play()
        }
    }
    
    @IBAction func addFishButtonAction(_ sender: UIButton) {
        view.addSubview(Octopus())
    }
    
    func update() -> Void {
        for sv in view.subviews {
            if let octopus = sv as? Octopus {
                octopus.move()
                caught(octopus: octopus)
            }
        }
        hook.dropHook()
        if !hook.drop {
            hookAudio.currentTime = 3
            hookAudio.stop()
        }
    }
    
    func caught(octopus: Octopus) -> Void {
        if octopus.center.x + 30 > hook.center.x && octopus.center.x - 30 < hook.center.x && hook.center.y + 200 > octopus.center.y - 15 && hook.center.y + 200 < octopus.center.y + 15 && !hook.caught  {
            hook.caught = true
            octopus.caught = true
            octopus.center.x = hook.center.x
        }
        if octopus.center.y < 0 {
            octopus.removeFromSuperview()
        }
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        for sv in view.subviews {
            if let fish = sv as? Octopus {
                fish.removeFromSuperview()
            }
        }
    }
    
    func song() -> Void {
        oceanAudio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "nhac song", ofType: ".mp3")!))
        oceanAudio.numberOfLoops = -1
        oceanAudio.prepareToPlay()
        oceanAudio.play()
        hookAudio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        hookAudio.currentTime = 3
        hookAudio.prepareToPlay()
    }
}
