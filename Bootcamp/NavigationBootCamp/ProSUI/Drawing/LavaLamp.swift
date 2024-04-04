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
//                            AnimatingPolygon()
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
//    AnimatingPolygon()
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

// MARK: - Array Extension
extension Array: VectorArithmetic, AdditiveArithmetic where Element == Double {
    public mutating func scale(by rhs: Double) {
      for (index, item) in self.enumerated() {
        self[index] = item * rhs
      }
    }
    public static func -(lhs: [Double], rhs: [Double]) -> [Double]{
        []
    }
    
    public var magnitudeSquared: Double { 0 }
    
    public static func +=(lhs: inout [Double], rhs: [Double]) {
      for (index, item) in rhs.enumerated() {
        lhs[index] += item
      }
    }
    public static func -=(lhs: inout [Double], rhs: [Double]) {
      for (index, item) in rhs.enumerated() {
        lhs[index] -= item
      }
    }
    
    public static var zero: Array<Double> = [0.0]
}

// MARK: - AnimatablePolygonShape
struct AnimatablePolygonShape: Shape {
    var animatableData: [Double]
    init(points: [Double]) {
        animatableData = points
    }
    func path(in rect: CGRect) -> Path {
        Path { path in
            // more code to come
            let center =  CGPoint(x: rect.width / 2, y: rect.height / 2)
            let radius = min(center.x, center.y)
            let lines = animatableData.enumerated().map { index, value in
              let fraction = Double(index) / Double(animatableData.count)
              let xPos = center.x + radius * cos(fraction * .pi * 2)
              let yPos = center.y + radius * sin(fraction * .pi * 2)
              return CGPoint(x: xPos /** value*/, y: yPos /** value*/)
            }
            path.addLines(lines)
        }
    }
}

// MARK: - AnimatingPolygon
struct AnimatingPolygon: View {
    @State private var points = Self.makePoints()
    @State private var timer = Timer.publish(every: 1, tolerance: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        AnimatablePolygonShape(points: points)
            .animation(.easeInOut(duration: 3), value: points)
            .onReceive(timer) { date in
                points = Self.makePoints()
            }
    }
    static func makePoints() -> [Double] {
        (0..<8).map { _ in .random(in: 0.8...1.2) }
    }
}
