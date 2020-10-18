//
//  AttachedComponent.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import Foundation
import RealityKit

class AttachedComponent: Component {
    
    public var attachedOn: Entity?
    
    init(attachedOn: Entity) {
        self.attachedOn = attachedOn
    }
    
    public func detach() {
        attachedOn?.components[SpotComponent.self]?.tryDetach()
    }
}
