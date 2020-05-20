//: [Introduction](@previous)
import Cocoa
import PlaygroundSupport
//: ## Creating Circuits
//: To create circuits in CLK we explore the concept of the `CLKModule`.
//: A `CLKModule` represents a collection of Inputs and Outputs and a relation of it's values.
//: This is where boolean logic enters the field. We may use modules to creat our logic gates.
//: The goal of this page is to impement a **NAND Gate** and verify it's behaviour.
//:
//: To create a NAND gate we need to know that it is just the negation of the AND gate, taking two inputs and one output.
//: So let's make a function that makes that relation explicity (the function signature is intended to later use it in the `CLKModule`):
//: nandLogic is not expressing relation but doing actual computation. This means that in this block the order matters.
func nandLogic(input: [CLKInput], output: [CLKOutput]) {
    /// we need a wire to connect the result of the and logic to the not logic
    /// A wire conforms to both CLKOutput and CLKInput
    let wire = CLKWire()
    CLKand(inputA: input[0], inputB: input[1], output: wire)
    CLKnot(input: wire, output: output[0])
}
/// This can be put in a `CLKModule` to create our desired NAND gate:
let nand = CLKModule(inputCount: 2, outputCount: 1, logic: nandLogic(input:output:))
/// Let's check it's truth table using `[input[0], input[1], output[0]]`
let tests:[[CLKState]] = [
    [.up,   .up,   .down],
    [.up,   .down, .up],
    [.down, .up,   .up],
    [.down, .down, .up]
]
for test in tests {
    nand.input[0].setValue(to: test[0])
    nand.input[1].setValue(to: test[1])
    if nand.output[0].getValue() != test[2] {
        print("Failed at test \(test)")
        break;
    }
}
//: If nothing has been printed in the console, everything is working as expected and we can use this to create a real NAND component:
class NAND: CLKModule {
    static func nandLogic(input: [CLKInput], output: [CLKOutput]) {
        /// we need a wire to connect the result of the and logic to the not logic
        /// A wire conforms to both CLKOutput and CLKInput
        let wire = CLKWire()
        CLKand(inputA: input[0], inputB: input[1], output: wire)
        CLKnot(input: wire, output: output[0])
    }
    
    init() {
        super.init(inputCount: 2, outputCount: 1, logic: NAND.nandLogic(input:output:))
    }
}
//: Using the same logic is possible to create all the other gates.
//: And because the logic is implementend as a closure it has the trade-of of not being an circuit, but also enables to run any code or test desired.
//: Let's try to make a SR Latch using our NANDs
//:
//: ![SR Latch Diagram](SR.png)
//: Instead of expressing this relation with logic, we may express it using relations:
class SR: CLKModule {
    init() {
        super.init(inputCount: 2, outputCount: 1, logic: {_,_ in })
        let nand1 = NAND()
        let nand2 = NAND()
        CLKBind(source: input[0], target: nand1.input[0])
        CLKBind(source: input[1], target: nand2.input[1])
        CLKBind(source: nand2.output[0], target: nand1.input[1])
        CLKBind(source: nand1.output[0], target: nand2.input[0])
        CLKBind(source: nand1.output[0], target: output[0])
    }
    
    // a helper function
    func set(s: CLKState, r: CLKState) {
        input[0].setValue(to: r)
        input[1].setValue(to: s)
    }
}

let sr = SR()

//: SR latches works in the following manner: `(.down, .up)` sets it to `.down` and `(.up, down)` sets it to` .up`. `(.up, .up)` keeps it states.
//: Let's use an led to give it more visual touch:
let led = CLKLed(with: .blue)
CLKBind(source: sr.output[0], target: led)
// Storing `.down` state
sr.set(s: .down, r: .up)
sr.set(s: .up, r: .up)
led
// Storing `.up` state
sr.set(s: .up, r: .down)
sr.set(s: .up, r: .up)
led

//: CLK enables a mix and match of swift code (the NAND logic) and relations (the SR init).
//: Next we consider the possibilities to interact and analyse other circuits using playground features.
//:
//: [Measuring Everything](@next)
