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
        overlayCoachingView()
        setupScene()
    }
    
    private func setupScene() {
        garageAnchor = try! Garage.loadGarageScene()
        arView.scene.anchors.append(garageAnchor!)
        
        // Set camera Anchor
        cameraAnchor = AnchorEntity(.camera)
        arView.scene.anchors.append(cameraAnchor as! HasAnchoring)
        
        // Add Tap Gesture Recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        arView.addGestureRecognizer(tapGestureRecognizer)
        
        setCommonGestures()
    }
    
    private func setCommonGestures() {
        if let wheel = garageAnchor?.wheel {
            GesturesComponent.registerComponent()
            wheel.components[GesturesComponent.self] = GesturesComponent(arView: arView, gestures: [.rotation, .scale, .translation], for: wheel)
        }
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        
//        let location = sender.location(in: arView)
//
//        if holdObject == nil {
//            if let entity = arView.entity(at: location) {
//                entity.components[HoldComponent.self]?.hold(onAnchor: cameraEntity!)
//                holdObject = entity
//            }
//        } else {
//            holdObject?.components[HoldComponent.self]?.release(onParent: pneuSpotEntity)
//            holdObject = nil
//        }
        
    }
    
    private func overlayCoachingView() {
        let coachingView = ARCoachingOverlayView(frame: arView.frame)
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        
        view.addSubview(coachingView)
    }
}
