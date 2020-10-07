//
//  HoldComponent.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 01/10/20.
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
        print("Segura peão!")
        
        entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
        
        var newTransform = entity.transform
        entity.setParent(anchor)
        newTransform.translation = [0,0, -0.30]
        newTransform.rotation = anchor.orientation
        entity.move(to: newTransform, relativeTo: entity.parent)
    }
    
    public func release() {
        print("Soltou do gado!")
        entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
    }
}
