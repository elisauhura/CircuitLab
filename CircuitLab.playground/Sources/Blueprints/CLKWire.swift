import Cocoa

open class CLKWire: CLKIO, CLKProbeable {
    // properties
    var innerState: CLKState {
        willSet {
            if newValue != innerState {
                stateChanged = true
            }
        }
        didSet {
            if stateChanged {
                for (_, prober) in probes {
                    prober.receive(newState: innerState)
                }
                stateChanged = false
            }
        }
    }
    
    var state: CLKState {
        get { self.innerState }
        set { self.innerState = newValue }
    }
    
    var stateChanged = false
    public var probes: [CLKProbeID : CLKProber] = [CLKProbeID : CLKProber]()
    
    // methods
    public init() {
        self.innerState = .down
    }
    
    public func getValue() -> CLKState {
        return state
    }
    
    public func setValue(to state: CLKState) {
        self.state = state
    }
    
    public func add(prober: CLKProber) -> CLKProbeID {
        var key = Int(arc4random())
        while probes[key] != nil {
            key = Int(arc4random())
        }
        probes[key] = prober
        return key
    }
    
    public func remove(proberAt proberId: CLKProbeID) {
        probes.removeValue(forKey: proberId)
    }
    
    public func probe() -> CLKState {
        return innerState
    }
}
