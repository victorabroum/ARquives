//
//  ViewController.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 16/10/20.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    public var garageAnchor: Garage.GarageScene?
    public var cameraAnchor: Entity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverlayCoachingView()
        setupScene()
    }
    
    private func setupScene() {
        
//        arView.debugOptions = [.showPhysics]
        
        garageAnchor = try! Garage.loadGarageScene()
        arView.scene.anchors.append(garageAnchor!)
        
        // Set camera Anchor
        cameraAnchor = AnchorEntity(.camera)
        arView.scene.anchors.append(cameraAnchor as! HasAnchoring)
        
        // Add Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
        
//        setCommonGestures()
        
        // Set custom gestures
        HandsController.shared.setHands(cameraAnchor!)
        
        prepareEntities(garageAnchor!.children)
    }
    
    private func setCommonGestures() {
        if let wheel = garageAnchor?.findEntity(named: "Wheel") {
            GesturesComponent.registerComponent()
            wheel.components[GesturesComponent.self] = GesturesComponent(arView: arView, gestures: [.rotation, .scale, .translation], for: wheel)
        }
    }
    
    private func prepareEntities(_ entites: Entity.ChildCollection) {
        for entity in (entites[0].children[0].children) {
            if entity.name == "Wheel" {
                entity.components[HoldComponent.self] = HoldComponent(entity: entity)
            }
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: arView)
        
        let hands = HandsController.shared
        
        if !hands.isHolding {
            if let entity = arView.entity(at: location) {
                hands.hold(entity)
            }
        } else {
            hands.release()
        }
    }
    
    private func setupOverlayCoachingView() {
        let coachingView = ARCoachingOverlayView(frame: arView.frame)
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        
        view.addSubview(coachingView)
    }
}
