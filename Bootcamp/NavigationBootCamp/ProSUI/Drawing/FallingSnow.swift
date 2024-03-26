//
//  FallingSnow.swift
//  Bootcamp
//
//  Created by Миляев Максим on 22.03.2024.
//

import SwiftUI

struct FallingSnow: View {
    
    @State private var particleSystem = SnowParticleSystem()
    
    var body: some View {
        LinearGradient(colors: [.red, .indigo], startPoint: .top,
                       endPoint: .bottom).mask {
            TimelineView(.animation) { timeline in
                Canvas { ctx, size in
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    particleSystem.update(date: timelineDate, size: size)
                    
//                    ctx.addFilter(.alphaThreshold(min: 0.5, color: .white))
                    ctx.addFilter(.blur(radius: 10))
                    
                    ctx.drawLayer { ctxt in
                        for particle in particleSystem.particles{
                            ctxt.opacity = particle.deathTime - timelineDate
                            ctxt.fill(Circle().path(in: CGRect(x: particle.x, y: particle.y, width: 32, height: 32)), with: .color(.white))
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    FallingSnow()
}


// MARK: - Particle

class SnowParticle {
    var x: Double
    var y: Double
    var xSpeed: Double
    var ySpeed: Double
    var deathTime: TimeInterval = Date.now.timeIntervalSinceReferenceDate + 2
    
    init(x: Double, y: Double, xSpeed: Double, ySpeed: Double) {
        self.x = x
        self.y = y
        self.xSpeed = xSpeed
        self.ySpeed = ySpeed
    }
}

// MARK: - Particle System

class SnowParticleSystem {
    var particles = [SnowParticle]()
    var lastUpdate = Date.now.timeIntervalSinceReferenceDate
    
    func update(date: TimeInterval, size: CGSize){
        let delta = lastUpdate - date
        self.lastUpdate = date
        
        //update all partices here
        
        for (index, particle) in particles.enumerated() {
            if particle.deathTime < date {
                particles.remove(at: index)
            } else {
                particle.x += particle.xSpeed * delta
                particle.y -= particle.ySpeed * delta
            }
        }
        
        
        //add new particle
        let newParticle = SnowParticle(x: .random(in: -32...size.width),
                                       y: .random(in: -32...size.height),
                                       xSpeed: .random(in: -50...50),
                                       ySpeed: .random(in: 100...500))
        self.particles.append(newParticle)
        
    }
}
