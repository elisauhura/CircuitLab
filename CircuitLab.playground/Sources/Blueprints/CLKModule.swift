import Foundation

open class CLKModule: CLKProber, CustomPlaygroundDisplayConvertible{
    // properties
    public var input: [CLKWire]
    public var output: [CLKWire]
    var ids: [CLKProbeID]
    let handler: ([CLKInput], [CLKOutput]) -> Void
    
    // methods
    public init(inputCount: Int, outputCount: Int, logic: @escaping ([CLKInput], [CLKOutput]) -> Void) {
        input = [CLKWire]()
        output = [CLKWire]()
        ids = [CLKProbeID]()
        self.handler = logic
        
        for _ in 0..<inputCount {
            let wire = CLKWire()
            ids.append(wire.add(prober: self))
            input.append(wire)
        }
        
        for _ in 0..<outputCount {
            output.append(CLKWire())
        }
    }
    
    deinit {
        for i in 0..<input.count {
            input[i].remove(proberAt: ids[i])
        }
    }
    
    public func receive(newState _: CLKState) {
        handler(input, output)
    }
    
    public var playgroundDescription: Any {
        return "Module with input \(input.map{$0.getValue() == .up ? 1 : 0}) and ouput \(output.map{$0.getValue() == .up ? 1 : 0})"
    }
}
