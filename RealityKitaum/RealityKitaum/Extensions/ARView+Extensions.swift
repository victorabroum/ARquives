//
//  ARView+Extensions.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 30/09/20.
//

import Foundation
import ARKit
import RealityKit

extension ARView {
    func enableRemoveObjects() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    @objc func handleLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let location = recognizer.location(in: self)
        
        if let entity = self.entity(at: location),
           let anchorEntity = entity.anchor,
           anchorEntity.name == "Anchor" {
            anchorEntity.removeFromParent()
            print("Remove anchor with name: \(anchorEntity.name)")
        }
    }
    
    
}
