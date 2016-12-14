//
//  Scene.swift
//  MicrophoneAnalysis
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 AudioKit. All rights reserved.
//

import AudioKit
import SpriteKit

class Scene : SKScene {
    
    var mic: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    
    let noteFrequencies = [16.35,17.32,18.35,19.45,20.6,21.83,23.12,24.5,25.96,27.5,29.14,30.87]
    let noteNamesWithSharps = ["C", "C♯","D","D♯","E","F","F♯","G","G♯","A","A♯","B"]
    let noteNamesWithFlats = ["C", "D♭","D","E♭","E","F","G♭","G","A♭","A","B♭","B"]
    
    // Label for amplitude
    let labelAmplitude = SKLabelNode(fontNamed: "Helvetica")
    let labelFrequency = SKLabelNode(fontNamed: "Helvetica")
    let labelNoteSharps = SKLabelNode(fontNamed: "Helvetica")
    let labelNoteFlats = SKLabelNode(fontNamed: "Helvetica")
    
    override func didMove(to view: SKView) {
        
        // Set the background color
        backgroundColor = SKColor.blue
        
        // Show the amplitude
        labelAmplitude.text = "Amplitude is: "
        labelAmplitude.fontColor = SKColor.white
        labelAmplitude.fontSize = 24
        labelAmplitude.zPosition = 150
        labelAmplitude.position = CGPoint(x: size.width / 2, y: size.height / 5 * 1)
        addChild(labelAmplitude)

        // Show the frequency
        labelFrequency.text = "Frequency is: "
        labelFrequency.fontColor = SKColor.white
        labelFrequency.fontSize = 24
        labelFrequency.zPosition = 150
        labelFrequency.position = CGPoint(x: size.width / 2, y: size.height / 5 * 2)
        addChild(labelFrequency)

        // Show the sharp notes
        labelNoteSharps.text = "Note (Sharps): "
        labelNoteSharps.fontColor = SKColor.white
        labelNoteSharps.fontSize = 24
        labelNoteSharps.zPosition = 150
        labelNoteSharps.position = CGPoint(x: size.width / 2, y: size.height / 5 * 3)
        addChild(labelNoteSharps)

        // Show the flat notes
        labelNoteFlats.text = "Note (Flats): "
        labelNoteFlats.fontColor = SKColor.white
        labelNoteFlats.fontSize = 24
        labelNoteFlats.zPosition = 150
        labelNoteFlats.position = CGPoint(x: size.width / 2, y: size.height / 5 * 4)
        addChild(labelNoteFlats)
        
        // Configure AudioKit
        AKSettings.audioInputEnabled = true
        mic = AKMicrophone()
        tracker = AKFrequencyTracker.init(mic)
        silence = AKBooster(tracker, gain: 0)

        // Start AudioKit
        AudioKit.output = silence
        AudioKit.start()
        
    }

    override func update(_ currentTime: TimeInterval) {
        
        // Only analyze if volume (amplitude) reaches a certain threshold
        if tracker.amplitude > 0.1 {
            
            // Show the frequency
            labelFrequency.text = "Frequency is: " + String(format: "%0.1f", tracker.frequency)
            
            // Not sure what this does, to be honest, it's from the AudioKit example file
            // I think it's to do with figuring out what note is playing
            var frequency = Float(tracker.frequency)
            while (frequency > Float(noteFrequencies[noteFrequencies.count-1])) {
                frequency = frequency / 2.0
            }
            while (frequency < Float(noteFrequencies[0])) {
                frequency = frequency * 2.0
            }

            // Not sure what this does either!
            // Need to ask Mr. Martin, who may understand the music theory better
            var minDistance: Float = 10000.0
            var index = 0
            
            for i in 0..<noteFrequencies.count {
                let distance = fabsf(Float(noteFrequencies[i]) - frequency)
                if (distance < minDistance){
                    index = i
                    minDistance = distance
                }
            }
            
            // Show the notes
            let octave = Int(log2f(Float(tracker.frequency) / frequency))
            labelNoteSharps.text = "Note (Sharps): " + "\(noteNamesWithSharps[index])\(octave)"
            labelNoteFlats.text = "Note (Flats): " + "\(noteNamesWithFlats[index])\(octave)"
            
            // Show the amplitude
            labelAmplitude.text = "Amplitude is: " + String(format: "%0.2f", tracker.amplitude)

        }
        
    }
    
}
