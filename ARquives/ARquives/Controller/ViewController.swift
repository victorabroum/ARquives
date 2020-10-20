//
//  ViewController.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import UIKit
import RealityKit
import ARKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    public var garageAnchor: Garage.GarageScene?
    public var cameraAnchor: Entity?
    public var collisionSubscribers: [Cancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverlayCoachingView()
        setupScene()
    }
    
    private func setupScene() {
        
//        arView.debugOptions = [.showPhysics]
        
        garageAnchor = try! Garage.loadGarageScene()
        arView.scene.anchors.append(garageAnchor!)
        
        setCommonGestures()
        
        // Set camera Anchor
        cameraAnchor = AnchorEntity(.camera)
        cameraAnchor?.setScale(Entity.defaultScale, relativeTo: nil)
        arView.scene.anchors.append(cameraAnchor as! HasAnchoring)

        // Add Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        arView.addGestureRecognizer(tapGestureRecognizer)

        // Configure Collision Detection
        detectCollision()

        // Set custom gestures
        HandsController.shared.setHands(cameraAnchor!)
        
        prepareEntities(garageAnchor!.children)
    }
    
    private func setCommonGestures() {
        for wheel in garageAnchor?.wheelEntities ?? [] {
            GesturesComponent.registerComponent()
            wheel.components[GesturesComponent.self] = GesturesComponent(arView: arView, gestures: [.all], for: wheel)
        }
    }
    
    private func prepareEntities(_ entites: Entity.ChildCollection) {
        // Prepare all custom Component
        HoldComponent.registerComponent()
        AttachedComponent.registerComponent()
        SpotComponent.registerComponent()
        
        for entity in entites {
            entity.scale = Entity.defaultScale
        }
        
        for wheel in garageAnchor?.wheelEntities ?? [] {
            wheel.components[HoldComponent.self] = HoldComponent(entity: wheel)
        }
        
        for wheelSpot in garageAnchor?.wheelSpotEntities ?? [] {
            wheelSpot.components[SpotComponent] = SpotComponent(spotEntity: wheelSpot)
            if let child = wheelSpot.children[0] as? HasModel {
                child.model?.materials = [SimpleMaterial(color: .init(red: 0, green: 0, blue: 1, alpha: 0), isMetallic: false)]
            }
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        if let entity = arView.entity(at: sender.location(in: arView)) {
            HandsController.shared.tryToGet(entity: entity)
        }
    }
    
    private func setupOverlayCoachingView() {
        let coachingView = ARCoachingOverlayView(frame: arView.frame)
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        
        view.addSubview(coachingView)
    }
    
    public func detectCollision() {
        collisionSubscribers.append(arView.scene.subscribe(to: CollisionEvents.Began.self, { [weak self] (event) in
            self?.verifyCollisionBetween(wheel: event.entityA, wheelSpot: event.entityB)
            self?.verifyCollisionBetween(wheel: event.entityB, wheelSpot: event.entityA)
        }))
    }
    
    private func verifyCollisionBetween(wheel: Entity, wheelSpot: Entity) {
        if wheelSpot.name == "Wheel Spot" &&
            wheel.name == "Wheel" {
            print("Colidiu certo!")
            
            wheelSpot.components[SpotComponent.self]?.tryAttach(entity: wheel)
        }
    }
}
