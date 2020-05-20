import Cocoa

// 8Segment
public class CLK8Segment: NSView {
    var module: CLKModule!
    public weak var a: CLKWire!
    public weak var b: CLKWire!
    public weak var c: CLKWire!
    public weak var d: CLKWire!
    public weak var e: CLKWire!
    public weak var f: CLKWire!
    public weak var g: CLKWire!
    public weak var dot: CLKWire!
    
    public init() {
        super.init(frame: NSRect(x: 0, y: 0, width: defaultUnit, height: defaultUnit*2))
        module = CLKModule(inputCount: 8, outputCount: 0) {
            _, _ in
            self.needsDisplay = true
        }
        a = module.input[0]
        b = module.input[1]
        c = module.input[2]
        d = module.input[3]
        e = module.input[4]
        f = module.input[5]
        g = module.input[6]
        dot = module.input[7]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(to state: [CLKState]) {
        a.setValue(to: state[0])
        b.setValue(to: state[1])
        c.setValue(to: state[2])
        d.setValue(to: state[3])
        e.setValue(to: state[4])
        f.setValue(to: state[5])
        g.setValue(to: state[6])
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.black.setFill()
        dirtyRect.fill()
        if dot.getValue() == .up {
            NSColor.red.setFill()
        } else {
            NSColor.gray.setFill()
        }
        NSBezierPath(ovalIn: NSRect(x: 26, y: 4, width: 2, height: 2)).fill()
        var path = NSBezierPath()
        path.lineWidth = 1.5
        // A
        if a.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path.move(to: NSPoint(x: 8, y: 56))
        path.line(to: NSPoint(x: 26, y: 56))
        path.stroke()
        // B
        if b.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 26, y: 54))
        path.line(to: NSPoint(x: 25, y: 34))
        path.stroke()
        // C
        if c.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 25, y: 30))
        path.line(to: NSPoint(x: 24, y: 10))
        path.stroke()
        // D
        if d.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 6, y: 8))
        path.line(to: NSPoint(x: 24, y: 8))
        path.stroke()
        // E
        if e.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 6, y: 10))
        path.line(to: NSPoint(x: 7, y: 30))
        path.stroke()
        // F
        if f.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 8, y: 54))
        path.line(to: NSPoint(x: 7, y: 34))
        path.stroke()
        // G
        if g.getValue() == .up {
            NSColor.red.setStroke()
        } else {
            NSColor.gray.setStroke()
        }
        path = NSBezierPath()
        path.lineWidth = 1.5
        path.move(to: NSPoint(x: 9, y: 32))
        path.line(to: NSPoint(x: 23, y: 32))
        path.stroke()
    }
}
