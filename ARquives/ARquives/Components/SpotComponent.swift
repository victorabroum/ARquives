//
//  SpotComponent.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import Foundation
import RealityKit

class SpotComponent: Component {
    
    public weak var spotEntity: Entity?
    
    public var hasAnyAttachedEntity: Bool = false
    
    public var attachedEntity: Entity? {
        didSet {
            hasAnyAttachedEntity = attachedEntity != nil
        }
    }
    
    init(spotEntity: Entity) {
        self.spotEntity = spotEntity
    }
    
    public func tryAttach(entity: Entity) {
        if !hasAnyAttachedEntity,
           let spot = spotEntity {
            attachedEntity = entity
            entity.components[AttachedComponent.self] = AttachedComponent(attachedOn: spot)
            entity.setParent(spot)
            entity.transform.translation = .zero
            entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
        }
    }
    
    public func tryDetach() {
        if hasAnyAttachedEntity {
            attachedEntity?.components[AttachedComponent.self] = nil
            attachedEntity = nil
        }
    }
}
