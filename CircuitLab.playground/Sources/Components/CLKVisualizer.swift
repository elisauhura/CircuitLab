import Cocoa

public class CLKVisualizer: CLKWire, CLKVisualizerBacker {
    // properties
    public var view: CLKVisualizerView! = nil
    public var values: [CLKState]
    
    public override init() {
        values = [CLKState].init(repeating: .fuzzy, count: 5)
        super.init()
        
        view = CLKVisualizerView(backedBy: self, frame: NSRect(x: 0, y: 0, width: defaultUnit * 4, height: defaultUnit * 2))
    }
    
    public override var state: CLKState {
        didSet {
            values.removeFirst()
            values.append(state)
            view.updateLayer()
            view.needsDisplay = true
        }
    }
}

public protocol CLKVisualizerBacker: AnyObject {
    var values: [CLKState] { get }
}

extension CLKVisualizer: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        self.view!
    }
}

public class CLKVisualizerView: NSView {
    weak var backer: CLKVisualizerBacker!
    let lineWidth = 2
    
    init(backedBy backer: CLKVisualizerBacker, frame: NSRect) {
        self.backer = backer
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.black.setFill()
        dirtyRect.fill()
        
        NSColor.green.setStroke()
        let path = NSBezierPath()
        path.move(to: NSPoint(x: 0, y: value(backer.values[0])))
        path.lineWidth = 2
        
        for i in 1..<5 {
            path.line(to: NSPoint(x: i * defaultUnit, y: value(backer.values[i])))
        }
        
        path.stroke()
    }
    
    func value(_ state: CLKState) -> Int {
        switch state {
        case .down:
            return 0 + lineWidth / 2
        case .fuzzy:
            return 1 * defaultUnit
        case .up:
            return 2 * defaultUnit - lineWidth/2
        }
    }
}
