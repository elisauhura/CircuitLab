import Cocoa

public class CLKLed: CLKWire {
    // properties
    let color: NSColor
    public let view: CLKLedView
    
    // methods
    public init(with color: NSColor) {
        self.color = color
        self.view = CLKLedView(frame: NSRect(x: 0, y: 0, width: defaultUnit, height: defaultUnit))
        
        super.init()
    }
    
    func updateView() {
        view.updateLayer()
        view.needsDisplay = true
    }
    
    // observers
    override var state: CLKState {
        didSet {
            if state == .up {
                view.color = color
            } else {
                view.color = defaultColor
            }
            updateView()
        }
    }
}

public class CLKLedView: NSView {
    public var color = defaultColor
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        color.setFill()
        
        NSBezierPath(ovalIn: dirtyRect).fill()
    }
}

extension CLKLed: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        self.view
    }
}
