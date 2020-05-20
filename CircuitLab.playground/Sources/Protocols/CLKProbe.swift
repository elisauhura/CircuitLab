import Foundation

public typealias CLKProbeID = Int

public protocol CLKProber {
    func receive(newState: CLKState)
}

public protocol CLKProbeable {
    func add(prober: CLKProber) -> CLKProbeID
    func remove(proberAt proberId: CLKProbeID)
    func probe() -> CLKState
    
    var probes: [Int: CLKProber] {get set}
}
