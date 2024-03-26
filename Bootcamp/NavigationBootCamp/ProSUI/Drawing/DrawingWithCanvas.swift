//
//  DrawingWithCanvas.swift
//  Bootcamp
//
//  Created by Миляев Максим on 21.03.2024.
//

import SwiftUI

struct DrawingWithCanvas: View {
    @State private var particleSystem = ParticleSystem()
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas{ ctx, size in
                //drawing code here
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                ctx.blendMode = .plusLighter
                ctx.addFilter(.blur(radius: 10))
                for particle in particleSystem.particles {
                    ctx.opacity = particle.deathDate - timelineDate
                    ctx
                        .fill(Circle()
                            .path(in: CGRect(x: particle.position.x - 16,
                                             y: particle.position.y - 16,
                                             width: 32,
                                             height: 32)),
                              with: .color(.cyan))
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { drag in
                    particleSystem.position = drag.location
                } )
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    DrawingWithCanvas()
}

// MARK: - Particle

struct Particle {
    var position : CGPoint
    var deathDate = Date.now.timeIntervalSinceReferenceDate + 1
}

// MARK: - Particle system

class ParticleSystem {
    var particles: [Particle] = []
    var position: CGPoint = .zero
    
    func update(date: TimeInterval){
        particles = particles.filter {$0.deathDate > date}
        particles.append(Particle(position: position))
    }
}

