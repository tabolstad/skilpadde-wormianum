//
//  AnimationView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/9/24.
//

import SwiftUI

/*
 Demonstrates multiple types of SwiftUI animation.
 Standard, Phase, Keyframe, Timeline

 From: SwiftUI Animations - Chris Eidhof
 https://www.youtube.com/watch?v=mzpZNaseAIE&t=1340s
*/

struct AnimationView: View {

    @State var isOn = true

    var body: some View {
        VStack {
            Description("Assorted shape animations. Tap to activate.")
            VStack {
                StrokingShapeView()
                PhaseAnimationView()
                KeyframeAnimationView()
            }
            TimelineAnimationView()
                .frame(height: 300)
        }
        .padding([.top, .leading, .trailing])
    }
}

struct StrokingShapeView: View {

    @State var isOn = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(.tertiary, lineWidth: 5)
            Circle()
                .trim(from: 0, to: isOn ? 1 : 0.0)
                .stroke(.red, lineWidth: 5)
        }
        .contentShape(Circle())
        .animation(.default.speed(0.2), value: isOn)
        .onTapGesture {
            isOn.toggle()
        }
    }
}

struct PhaseAnimationView: View {

    @State var isOn = false

    var body: some View {
        PhaseAnimator([false, true, false, true], trigger: isOn) { active in
            Rectangle()
                .fill(isOn ? .yellow : .gray)
                .rotationEffect(.degrees(active ? -9 : 0))
                .scaleEffect(active ? 1.2 : 1)
                .offset(
                    x: active ? 50 : 0,
                    y: active ? -50 : 0
                )
        }
        .onTapGesture {
            isOn.toggle()
        }
        .padding()
    }
}

struct KeyframeAnimationView: View {

    struct KeyframeValue {
        var opacity: Double
        var trim: Double
    }

    @State var isOn = false

    // swiftlint:disable:next identifier_name
    let on = KeyframeValue(opacity: 1, trim: 1)
    let off = KeyframeValue(opacity: 0.1, trim: 0)

    var body: some View {
        KeyframeAnimator(
            initialValue: isOn ? on : off,
            trigger: isOn
        ) { value in
            ZStack {
                Circle()
                    .fill(Color.green.opacity(value.opacity))
                Circle()
                    .trim(from: 0, to: value.trim)
                    .stroke(.green, lineWidth: 5)
            }
        } keyframes: { _ in
            KeyframeTrack(\.opacity) {
                if isOn {
                    MoveKeyframe(0.1)
                    CubicKeyframe(0.1, duration: 1.5)
                    CubicKeyframe(1, duration: 1)
                } else {
                    MoveKeyframe(1)
                    CubicKeyframe(0.1, duration: 2)
                }
            }
            KeyframeTrack(\.trim) {
                if isOn {
                    MoveKeyframe(0)
                    CubicKeyframe(1, duration: 2)
                } else {
                    MoveKeyframe(1)
                    CubicKeyframe(0, duration: 2)
                }
            }
        }
        .onTapGesture {
            isOn.toggle()
        }
    }
}

struct ParticleModifier: ViewModifier {

    @State var startTime = Date.now
    @State var particles: [Particle] = []

    struct Particle: Codable {
        var amplitude: CGFloat = .random(in: -50...50)
        var delay: TimeInterval = .random(in: 0...2)
    }

    func body(content: Content) -> some View {
        content
            .background {
                TimelineView(.animation) { timelineCtx in
                    let elapsed = timelineCtx.date.timeIntervalSince(startTime)
                    Canvas { ctx, size in
                        if let heart = ctx.resolveSymbol(id: "particle") {
                            ctx.translateBy(x: size.width / 2, y: size.height / 2)
                            // swiftlint:disable identifier_name
                            for p in particles {
                                let time = elapsed - p.delay
                                guard time > 0 else { continue }
                                let x = sin(time * .pi) * p.amplitude
                                let y = time * -20
                                ctx.opacity = 1 - time / 5
                                ctx.draw(heart, at: CGPoint(x: x, y: y))
                            }
                            // swiftlint:enable identifier_name
                        }
                    } symbols: {
                        content.tag("particle")
                    }
                }
                .frame(width: 300, height: 200)
            }
            .onTapGesture {
                startTime = Date.now
                particles = (0..<5).map { _ in
                    Particle()
                }
            }
    }
}

struct TimelineAnimationView: View {
    @State var isOn = false

    var body: some View {
        Image(systemName: "eye")
            .symbolVariant(.fill)
            .foregroundStyle(.red)
            .font(.system(size: 80))
            .modifier(ParticleModifier())
    }
}

#Preview {
    AnimationView()
}
