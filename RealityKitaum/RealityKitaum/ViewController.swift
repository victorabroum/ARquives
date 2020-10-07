//
//  ViewController.swift
//  RealityKitaum
//
//  Created by Victor Vasconcelos on 30/09/20.
//

import UIKit
import RealityKit
import ARKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    public var collisionSubs: [Cancellable] = []
    
    public var holdObject: Entity?
    public var cameraEntity: Entity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayCoachingView()
//        showModel()
//        arView.enableRemoveObjects()
        showFromRealityComposer()
        
        arView.session.delegate = self
        arView.debugOptions = [.showPhysics]
        detectCollision()

        cameraEntity = AnchorEntity(.camera)       // ARCamera anchor
        arView.scene.addAnchor(cameraEntity as! HasAnchoring)
    }
    
    func showFromRealityComposer() {
        let anchor = try! Experience.loadGarage()
        
        prepareEntities(anchor.children)
        
        arView.scene.anchors.append(anchor)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func prepareEntities(_ entites: Entity.ChildCollection) {
        HoldComponent.registerComponent()
        for entity in (entites[0].children[0].children) {
            if entity.name == "tire" {
                entity.components[HoldComponent.self] = HoldComponent(entity: entity)
                entity.generateCollisionShapes(recursive: true)
            } else if entity.name == "tireSpot" {
                let tireSpot = TireSpotEntity(color: .red, model: entity.children[0] as! HasModel)
                entity.addChild(tireSpot)
//                tireSpot.addCollisions()
                
                
            }
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: arView)
        
        if holdObject == nil {
            if let entity = arView.entity(at: location) {
                entity.components[HoldComponent.self]?.hold(onAnchor: cameraEntity!)
                holdObject = entity
            }
        } else {
            holdObject?.components[HoldComponent.self]?.release()
            holdObject = nil
        }
        
    }
    
    func overlayCoachingView() {
        let coachingView = ARCoachingOverlayView(frame: arView.frame)
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        
        view.addSubview(coachingView)
    }
    
    func showModel() {
        // Anchor apenas para planos horizontais e com no mínimo 20cm quadrados
        let anchorEntity = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        anchorEntity.name = "Anchor"
        let entity = try! Entity.loadModel(named: "trowel")
        entity.setParent(anchorEntity)

        arView.scene.anchors.append(anchorEntity)
        
        let boxEntity = ModelEntity(
            mesh: .generateBox(size: 2),
            materials: [
                SimpleMaterial(color: .red, isMetallic: false)
            ])
        boxEntity.transform.translation.y = 5
        entity.addChild(boxEntity)
        
        // Add Gestures if need
        addGestures(on: entity)
    }
    
    func addGestures(on model: Entity) {
        model.generateCollisionShapes(recursive: true)
        
        arView.installGestures([.rotation, .translation], for: model as! HasCollision)
    }
}
