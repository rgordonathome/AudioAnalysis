//
//  ViewController.swift
//  MicrophoneAnalysis
//
//  Created by Kanstantsin Linou on 6/14/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import Cocoa
import AudioKit
import SpriteKit

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the game scene
        let scene = Scene(size: CGSize(width: 440, height: 200))
        
        // Configure and present the scene
        let skView = SKView(frame: NSRect(origin: CGPoint(x: 20, y: 11), size: CGSize(width: 440, height: 200)))
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        view.addSubview(skView)
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

