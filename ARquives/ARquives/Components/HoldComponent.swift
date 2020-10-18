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
    
    public func hold(onAnchor camAnchor: Entity) {
        entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
        
        var newTransform = entity.transform
        entity.setParent(camAnchor)
        newTransform.translation = [0,0, -0.30]
        newTransform.rotation = camAnchor.orientation
        entity.move(to: newTransform, relativeTo: entity.parent)
        
        entity.components[AttachedComponent.self]?.detach()
    }
    
    public func release(onParent parent: Entity?) {
        entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
    }
}
