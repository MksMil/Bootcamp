//
//  LavaLamp.swift
//  Bootcamp
//
//  Created by Миляев Максим on 26.03.2024.
//

import SwiftUI

struct LavaLamp: View {
    
    @State private var parcticleSystem = LavaLampParticleSystem(count: 15)
    @State private var threshold = 0.5
    @State private var blur = 30.0
    
    var body: some View {
        VStack{
            LinearGradient(colors: [.red, .orange],
                           startPoint: .top,
                           endPoint: .bottom)
            .mask {
                TimelineView(.animation) { timeline in
                    Canvas{ ctx, size in
                        parcticleSystem.update(date: timeline.date.timeIntervalSinceReferenceDate,
                                               size: size)
                        
                        ctx.addFilter(.alphaThreshold(min: threshold))
                        ctx.addFilter(.blur(radius: blur))
                        
                        ctx.drawLayer { innerCtx in
                            //draw particles here
                            for particle in parcticleSystem.particles{
                                guard let shape = innerCtx.resolveSymbol(id: particle.id) else { continue }
                                innerCtx.draw(shape, at: CGPoint(x: particle.x * size.width,
                                                            y: particle.y * size.height))
                            }
                            
                        }
                    }symbols: {
                        //create symbols here
                        ForEach(parcticleSystem.particles) { particle in
                            Circle()
                                .frame(width: particle.size, height: particle.size)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.indigo)
        LabeledContent("Threshold") {
            Slider(value: $threshold, in: 0.01...0.99)
        }
        .padding(.horizontal)
        LabeledContent("Blur") {
            Slider(value: $blur, in: 0...40)
        }
        .padding(.horizontal)
    }
}


#Preview {
    LavaLamp()
}

// MARK: - LavaLampParcticle

class LavaLampParcticle: Identifiable {
    let id = UUID()
    var size = Double.random(in: 100...250)
    var x = Double.random(in: -0.1...1.1)
    var y = Double.random(in: -0.25...1.25)
    var isMovingDown = Bool.random()
    var speed = Double.random(in: 0.01...0.1)
}

// MARK: - LavaLampParticleSystem
class LavaLampParticleSystem {
    let particles: [LavaLampParcticle]
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    init(count: Int){
        self.particles = (0..<count).map{ _ in LavaLampParcticle() }
    }
    
    func update(date: TimeInterval, size: CGSize){
        let delta = date - lastUpdate
        lastUpdate = date
        
        for particle in particles {
            //move the particle
            if particle.isMovingDown {
                particle.y += particle.speed * delta
                if particle.y > 1.25 {
                    particle.isMovingDown = false
                }
            } else {
                particle.y -= particle.speed * delta
                if particle.y < -0.25 {
                    particle.isMovingDown = true
                }
            }
        }
    }
}

