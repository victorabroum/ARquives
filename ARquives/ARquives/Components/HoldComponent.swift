//
//  HoldComponent.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import Foundation
import RealityKit

class HoldComponent: Component {
    var isHold: Bool = false
    var entity: Entity
    
    public init(entity: Entity) {
        self.entity = entity
    }
    
    public func hold(onAnchor anchor: Entity) {
        entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
        
        var newTransform = entity.transform
        entity.setParent(anchor)
        newTransform.translation = [0,0, -0.30]
        newTransform.rotation = anchor.orientation
        entity.move(to: newTransform, relativeTo: entity.parent)
    }
    
    public func release(onParent parent: Entity?) {
        if let newParent = parent {
            entity.setParent(newParent)
            entity.transform.translation = .zero
        } else {
            entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
        }
    }
}
