import Foundation

public class CLKBind: CLKProber {
    public func receive(newState: CLKState) {
        if target.getValue() != newState {
            target.setValue(to: source.probe())
        }
    }
    
    var target: CLKIO!
    var source: CLKProbeable!
    var probeId: Int
    
    public init(source: CLKProbeable, target: CLKIO) {
        self.source = source
        self.target = target
        self.probeId = 0
        if target.getValue() != source.probe() {
            target.setValue(to: source.probe())
        }
        self.probeId = source.add(prober: self)
    }
    
    public func remove() {
        source.remove(proberAt: probeId)
        target = nil
        source = nil
    }
}
