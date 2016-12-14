//
//  Scene.swift
//  MicrophoneAnalysis
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import SpriteKit

class Scene : SKScene {
    
    let amplitudeLabel = SKLabelNode(fontNamed: "Helvetica")
    
    override func didMove(to view: SKView) {
        
        // Set the background color
        backgroundColor = SKColor.blue
        
        // Show the amplitude
        amplitudeLabel.text = "nothing analyzed yet"
        amplitudeLabel.fontColor = SKColor.white
        amplitudeLabel.fontSize = 24
        amplitudeLabel.zPosition = 150
        amplitudeLabel.position = CGPoint(x: size.width / 2, y: size.height / 5 * 2)
        addChild(amplitudeLabel)
        
        
    }

    override func update(_ currentTime: TimeInterval) {
        
        
        
    }
    
}
