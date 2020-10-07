//
//  TireSpotEntity.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 02/10/20.
//

import Foundation
import ARKit
import RealityKit
import Combine

class TireSpotEntity: Entity, HasModel, HasCollision {
    
    var collisionSubs: [Cancellable] = []
    
    required init(color: UIColor, model: HasModel) {
        super.init()
        
        self.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateSphere(radius: 0.025)],
            mode: .trigger,
            filter: .sensor)
        
        self.components[ModelComponent] = ModelComponent(
            mesh: model.model!.mesh,
            materials: [SimpleMaterial(
                            color: color,
                            isMetallic: false)
            ]
        )
        
        self.transform = model.transform
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
}
