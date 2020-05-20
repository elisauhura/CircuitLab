//: [Creating Circuits](@previous)
import Cocoa
import PlaygroundSupport
//: ## Measuring Everything
//: Now we explore the possibilities of measurements of our circuits.
//:
//: Let's first create a `CLKModule` with a special behavior.
//: It will be called Counter, it counts the number of ticks of a clock source and when it reaches a target value, it sets its output to .up for a cycle and resets its counter to 0.
//:
//: Considering the nature of the component, lets use swift for the couting bit (logic relations can be used just to be clear).
// Trying to count the cycles is a good stater point.
var cycle_counts = 0
let countUp = CLKModule(inputCount: 1, outputCount: 0, logic: {
    input, _ in
    if input[0].getValue() == .up {
        cycle_counts += 1
    }
})
let clock = CLKClock(upDuration: 0.1, downDuration: 0.1)
let bind = CLKBind(source: clock, target: countUp.input[0])
// Let's keep the binding for 2 seconds, wich should yeld 10 cycles
Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
    bind.remove()
    print("Counted up to \(cycle_counts)")
}
// Now we can just pack it's logic
class Counter {
    var count: Int = 0
    var module: CLKModule! = nil
    var input: CLKWire! = nil
    var output: CLKWire! = nil
    
    init(countUpTo count: Int) {
        module = CLKModule(inputCount: 1, outputCount: 1) {
            input, output in
            if input[0].getValue() == .up {
                self.count += 1
            }
            if self.count >= count {
                self.count = 0
                output[0].setValue(to: .up)
            } else {
                output[0].setValue(to: .down)
            }
        }
        
        input = module.input[0]
        output = module.output[0]
    }
}
//: To check our counter we can use an Oscilloscope!
//: It shall check the value of our counter and show it just like an oscilloscope would.
class Oscilloscope: NSView, CLKProber {
    // This enables the oscilloscope to sync with the clock
    func receive(newState: CLKState) {
        var value = -50
        if target.getValue() == .up {
            value = 50
        }
        measures.removeFirst()
        measures.append(value)
        needsDisplay = true
    }
    
    var measures: [Int]
    let resolution = 50
    let width: Double = 200
    let time: TimeInterval = 0.05
    let target: CLKInput
    
    init(of target: CLKInput) {
        self.target = target
        measures = [Int].init(repeating: 0, count: resolution)
        super.init(frame: NSRect(x: 0, y: 0, width: width, height: 200))
    }
    
    override func draw(_ dirtyRect: NSRect) {
        NSColor.black.setFill()
        dirtyRect.fill()
        NSColor.green.setStroke()
        let path = NSBezierPath()
        path.move(to: NSPoint(x: 0, y: 100 + measures[0]))
        for i in 1..<measures.count {
            path.line(to: NSPoint(x: width/Double(resolution-1)*Double(i), y: Double(100 + measures[i])))
        }
        path.stroke()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
let counter = Counter(countUpTo: 10)
let oscilloscope = Oscilloscope(of: counter.output)
CLKBind(source: clock, target: counter.input)
clock.add(prober: oscilloscope)
PlaygroundPage.current.liveView = oscilloscope
//: As expected, the oscilloscope shows us that the counter is setting to `.up` every 2 seconds-ish 😬.
//: Using the liveView, we can analyse and study the circuit with simple tools like the oscilloscope.
//: Next and lastly, lets see how to use more tools, add some interaction and make more binds!
//: [Exploring Possibilities](@next)
