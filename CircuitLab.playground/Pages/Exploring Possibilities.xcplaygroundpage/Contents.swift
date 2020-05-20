//: [Measuring Everything](@previous)
import Cocoa
import PlaygroundSupport
//: ## Exploring Possibilities
//: Let's create a cronometer.
//: It will have two buttons: a reset to start over and a pause.
//: We need a way to represent numbers visually and also to interact with our buttons and maybe probe some signals using oscilloscopes. And some timers to control the time to be displayed.
/// CLKBench creates a view were we can organize our visual elements
let bench = CLKBench(frame: NSRect(x: 0, y: 0, width: 449, height: 321))
PlaygroundPage.current.liveView = bench
/// We need four 8Segment displays to hold our numbers
let numbers = [CLK8Segment(),CLK8Segment(),CLK8Segment(),CLK8Segment()]
/// A button to pause the cronometer
/// Pressing it alters its states
let pause = CLKButton(at: .down)
/// And another to reset the cronometer
/// Pressing it alters its states briefly
/// So we may use a  CLKBlueButton
let reset = CLKBlueButton()
/// A oscilloscope to check the clock is very useful
let clock = CLKClock(upDuration: 0.5, downDuration: 0.5)
let oscilloscope = CLKOscilloscope(of: clock)
/// This will the the oscilloscope clock
CLKClock(upDuration: 0.1, downDuration: 0.1).add(prober: oscilloscope)
/// Now we can add ou components to the bench
bench.add(component: CLKViewPair.from(array: numbers), named: "clock", x: 35, y: 177)
bench.add(component: pause.view, named: "pause", x: 42, y: 92)
bench.add(component: reset.view, named: "reset", x: 134, y: 94)
bench.add(component: oscilloscope, named: "oscilloscope", x: 217, y: 87)
/// (You may drag the components using its borders)
/// Firstly we need a way to pause the system.
/// We can use the pause button to control our clock using an and gate.
class AND: CLKModule {
    static func andLogic(input: [CLKInput], output: [CLKOutput]) {
        CLKand(inputA: input[0], inputB: input[1], output: output[0])
    }
    
    init() {
        super.init(inputCount: 2, outputCount: 1, logic: AND.andLogic(input:output:))
    }
}

let and = AND()
CLKBind(source: clock, target: and.input[0])
CLKBind(source: pause, target: and.input[1])
oscilloscope.target = and.output[0]
/// Now we  create a way to count from 0 to 9
class DigitCounter {
    var clock: CLKWire! = nil
    var reset: CLKWire! = nil
    var carry: CLKWire! = nil
    var module: CLKModule! = nil
    var display: CLK8Segment
    
    var count = 0 {
        didSet {
            display.set(to: configuration[count])
        }
    }
    
    let configuration: [[CLKState]] = [
        [.up, .up, .up, .up, .up, .up,.down], //0
        [.down, .up, .up, .down, .down, .down, .down], //1
        [.up, .up, .down, .up, .up, .down, .up], //2
        [.up, .up, .up, .up, .down, .down, .up], //3
        [.down, .up, .up, .down, .down, .up, .up], //4
        [.up, .down, .up, .up, .down, .up, .up], //5
        [.up, .up, .up, .up, .up, .down, .up], //6
        [.up, .up, .up, .down, .down, .down, .down], //7
        [.up, .up, .up, .up, .up, .up, .up], //8
        [.up, .up, .up, .down, .down, .up, .up], //9
    ]
    
    init(with display: CLK8Segment) {
        self.display = display
        module = CLKModule(inputCount: 2, outputCount: 1) {
            input, output in
            /// reset is .up
            if input[1].getValue() == .up {
                output[0].setValue(to: .down)
                self.count = 0
            } else {
                if input[0].getValue() == .up {
                    if self.count >= 9 {
                        self.count = 0
                        output[0].setValue(to: .up)
                    } else {
                        self.count += 1
                        output[0].setValue(to: .down)
                    }
                }
            }
        }
        clock = module.input[0]
        reset = module.input[1]
        carry = module.output[0]
    }
}
// Create the binds
let counter1 = DigitCounter(with: numbers[3])
let counter2 = DigitCounter(with: numbers[2])
let counter3 = DigitCounter(with: numbers[1])
let counter4 = DigitCounter(with: numbers[0])
CLKBind(source: and.output[0], target: counter1.clock)
CLKBind(source: counter1.carry, target: counter2.clock)
CLKBind(source: counter2.carry, target: counter3.clock)
CLKBind(source: counter3.carry, target: counter4.clock)
numbers[1].dot.setValue(to: .up)
CLKBind(source: reset, target: counter1.reset)
CLKBind(source: reset, target: counter2.reset)
CLKBind(source: reset, target: counter3.reset)
CLKBind(source: reset, target: counter4.reset)
// And here it is!
// Click the red button to play!
// Grazie!

//: That's the end!
