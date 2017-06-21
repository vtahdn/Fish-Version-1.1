//
//  Hook.swift
//  Fish Version 1.1
//
//  Created by Viet Anh Doan on 6/21/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit

class Hook: UIImageView{
    var drop = false
    var speed = 5
    var caught = false
    init() {
        let image = UIImage(named: "hook.png")
        super.init(image: image)
        self.frame = CGRect(x: 0, y: -180, width: 50, height: 0)
        self.contentMode = .scaleAspectFill
    }
    
    func dropHook() -> Void {
        if drop {
            self.center.y += CGFloat(speed)
            if self.center.y > 220 {
                speed = -speed
            }
            if self.center.y < -180 {
                speed = 5
                self.center.y = -175
                drop = false
                caught = false
            }
            if caught {
                speed = -10
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
