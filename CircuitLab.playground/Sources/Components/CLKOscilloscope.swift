import Cocoa

public class CLKOscilloscope: NSView, CLKProber {
    // This enables the oscilloscope to sync with the clock
    public func receive(newState: CLKState) {
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
    public var target: CLKInput
    
    public init(of target: CLKInput) {
        self.target = target
        measures = [Int].init(repeating: 0, count: resolution)
        super.init(frame: NSRect(x: 0, y: 0, width: width, height: 120))
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.black.setFill()
        dirtyRect.fill()
        NSColor.green.setStroke()
        let path = NSBezierPath()
        path.move(to: NSPoint(x: 0, y: 60 + measures[0]))
        for i in 1..<measures.count {
            path.line(to: NSPoint(x: width/Double(resolution-1)*Double(i), y: Double(60 + measures[i])))
        }
        path.stroke()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
