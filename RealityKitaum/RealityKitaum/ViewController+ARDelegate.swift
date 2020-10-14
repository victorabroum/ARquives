//
//  ViewController+ARDelegate.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 01/10/20.
//

import Foundation
import RealityKit
import ARKit

extension ViewController: ARSessionDelegate {
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        print("AR Camera position \(arView.cameraTransform.translation)")
        
//        let cameraPosition = arView.cameraTransform.translation
//        
//        if let object = holdObject {
//            
//            object.components[PhysicsBodyComponent.self]?.mode = .kinematic
//            
//            var newTransform = object.transform
//            newTransform.translation = SIMD3<Float>(cameraPosition.x,
//                                                    cameraPosition.y,
//                                                    cameraPosition.z - 0.15)
//            newTransform.rotation = arView.cameraTransform.rotation
//            
//            if let cameraEntity = self.cameraEntity {
//                print("NOVO PAI CAMERA")
//                object.setParent(cameraEntity)
//            }
//            
//            object.move(to: newTransform, relativeTo: nil)
//        }
    }
    
    func detectCollision() {
        let scene = self.arView.scene
        
        collisionSubs.append(scene.subscribe(to: CollisionEvents.Began.self, { (event) in
//            print("TOCOU")
            
//            guard let entityA = event.entityA as? TireSpotEntity else {
//                return
//            }
//            print("Enconstei na entityA \(entityA.name)")
            
            self.tireCollideWithSpot(entityA: event.entityA, entityB: event.entityB)
            self.tireCollideWithSpot(entityA: event.entityB, entityB: event.entityA)
            
        }))
    }
    
    func tireCollideWithSpot(entityA: Entity, entityB: Entity) {
        if entityA as? TireSpotEntity != nil &&
            entityB.name == "tire"{
            print("PNEU COM SPOT OKAY")
            self.pneuSpotEntity = entityA
        }
    }
}
