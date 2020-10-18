//
//  TireSpotEntity+Collision.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 02/10/20.
//

import Foundation
import RealityKit

extension TireSpotEntity {
    func addCollisions() {
        guard let scene = self.scene else {
            return
        }
        
        collisionSubs.append(scene.subscribe(to: CollisionEvents.Began.self, on: self) { event in
            guard let boxA = event.entityA as? TireSpotEntity else {
                return
            }
            print("Encostei \(boxA.name)")
        })
        
        collisionSubs.append(scene.subscribe(to: CollisionEvents.Ended.self, on: self) { event in
            guard let boxA = event.entityA as? TireSpotEntity else {
                return
            }
            print("Parou de encostar \(boxA.name)")
        })
    }
}
