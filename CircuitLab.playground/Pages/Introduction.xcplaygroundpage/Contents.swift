//: # Circuit Lab Kit (CLK)
//: Create and experiment with digital circuits
//:(_By default all components are grounded_)
//:
//: (Playground made in 24hrs 😅)
//: (Run the code as you read it)
import Cocoa
import PlaygroundSupport
//: ## Introduction
//: Digital circuits are a very interesting topic to explore.
//: This playground is meant to enable people to experiment and test its circuits using code and graphics.
//:
//: To get started lets make a **blinking led!**
//: The led is created using the `CLKLed` class.
let led = CLKLed(with: .red)
//: Our led is off? 🧐
//:
//: Components in the Circuit Lab Kit have Input and or Output.
//: If a component conforms to `CLKInput` that means that the component may be used as input by other components.
//: If a component conforms to `CLKOutput` that means that the compoment may be used as output by other components.
//: We can set a `CLKOutput` component to a value state at any time using `.setValue(to:)` method.
//:
//: To turn on the led we need to set it's output to `.up`
led.setValue(to: .up)
//: But in real circuits a led cannot turn on by itself, it needs a proper input to drive its output to `.up`.
//: So to make it blink we may use the `CLKClock` component. A clock signal is a digital signal that swicthes between `.down` and `.up` states given time intervals.
//: To make a clock that stays one second `.up` and half a second `.down` we use the following sintax:
let clock = CLKClock(upDuration: 1, downDuration: 0.5)
//: Now we can use a bind that connects our `clock` to ou `led`.
let bind = CLKBind(source: clock, target: led)
//: To see our led live, we just set the liveView to it's view (you may also need to toogle it with ⌥⌘⮐)
PlaygroundPage.current.liveView = led.view
//: Our blinking led is complete. So lets experiment with some more complex circuits.
//:
//: [Creating Circuits](@next)
