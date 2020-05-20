import Cocoa
import Dispatch

public class CLKClock: CLKInput, CLKProbeable, CustomPlaygroundDisplayConvertible {
    // properties
    let upDuration: TimeInterval
    let downDuration: TimeInterval
    
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
            }
        }
    }
    
    var state: CLKState {
        get { self.innerState }
        set { self.innerState = newValue }
        
    }
    
    var stateChanged = true
    public var probes: [CLKProbeID : CLKProber] = [CLKProbeID : CLKProber]()
    
    public var playgroundDescription: Any {
        return "Clock that stays up for \(upDuration) seconds and down for \(downDuration) seconds."
    }
    
    // methods
    public init(upDuration: TimeInterval, downDuration: TimeInterval) {
        self.innerState = .down
        self.upDuration = upDuration
        self.downDuration = downDuration
        
        clock()
    }
    
    func clock() {
        if state == .down {
            state = .up
            Timer.scheduledTimer(withTimeInterval: upDuration, repeats: false) { _ in
                self.clock()
            }
        } else {
            state = .down
            Timer.scheduledTimer(withTimeInterval: downDuration, repeats: false) { _ in
                self.clock()
            }
        }
        
    }

    
    public func getValue() -> CLKState {
        return state
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

