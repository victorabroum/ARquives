//
//  HandsController.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import Foundation
import RealityKit

class HandsController {
    private init() {
        HoldComponent.registerComponent()
    }
    
    public static var shared = HandsController()
    
    var isHolding: Bool = false
    
    var holdingEntity: Entity? {
        didSet {
            isHolding = holdingEntity != nil
        }
    }
    
    var hands: Entity?
    
    public func setHands(_ entity: Entity) {
        self.hands = entity
    }
    
    public func hold(_ entity: Entity) {
        if !isHolding {
            entity.components[HoldComponent.self]?.hold(onAnchor: hands!)
            holdingEntity = entity
        }
    }
    
    public func release(onParent parent: Entity? = nil) {
        if isHolding {
            holdingEntity?.components[HoldComponent.self]?.release(onParent: parent)
            holdingEntity = nil
        }
    }
}
