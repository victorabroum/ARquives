//
//  GesturesComponent.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import Foundation
import RealityKit
import ARKit

class GesturesComponent: Component {
    
    init(arView: ARView, gestures: ARView.EntityGestures, for entity: Entity) {
        // Generate Collision Shaped for All childrens
        entity.generateCollisionShapes(recursive: true)
        
        entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
        
        arView.installGestures(gestures, for: entity as! HasCollision)
    }
    
}
