//
//  Octopus.swift
//  Fish Version 1.1
//
//  Created by Viet Anh Doan on 6/21/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit

class Octopus: UIImageView {

    var speed = 0
    var vy = 0
    var pulled = false
    var caught = false
    
    init() {
        let image = UIImage(named: "octopus.png")
        super.init(image: image)
        speed = Int(arc4random_uniform(5)) + 2
        vy = Int(arc4random_uniform(5)) - 2
        self.frame = CGRect(x: -60, y: self.bounds.size.height/3, width: 60, height: 60)
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move() -> Void {
        if caught && !pulled {
            self.transform = self.transform.rotated(by: CGFloat(M_PI_2))
            pulled = true
        }
        if pulled {
            self.center.y -= 10
        }
        if !caught && !pulled {
            self.center.x += self.transform == .identity ? 3 : -3
            self.center.y += CGFloat(vy)
        }
        if self.center.y < 0.25*(superview?.bounds.size.height)! || self.center.y > 0.75*(superview?.bounds.size.height)! {
            vy = -vy
        }
        if self.center.x > (superview?.bounds.size.width)! + 30 {
            self.transform = self.transform.scaledBy(x: -1, y: 1)
        }
        if self.center.x < -30 {
            self.transform = .identity
        }
    }

}
