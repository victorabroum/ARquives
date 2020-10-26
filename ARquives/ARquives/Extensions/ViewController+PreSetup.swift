//
//  ViewController+PreSetup.swift
//  ARquives
//
//  Created by Victor Vasconcelos on 23/10/20.
//

import Foundation
import RealityKit
import ARKit

extension ViewController {
    public func setupOverlayCoachingView() {
        let coachingView = ARCoachingOverlayView(frame: arView.frame)
        
        coachingView.session = arView.session
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        
        view.addSubview(coachingView)
    }
}
