import Cocoa

public class CLKSwitch: CLKWire {
    // properties
    public var view: CLKSwitchView
    
    public var switchState: CLKSwitchState {
        didSet {
            if switchState == .closed {
                view.closed = true
            } else {
                view.closed = false
            }
        }
    }
    
    public override var state: CLKState {
        set {
            self.innerState = newValue
        }
        
        get {
            if switchState == .closed {
                return .down
            } else {
                return innerState
            }
        }
    }
    
    // methods
    public init(at state: CLKSwitchState) {
        switchState = state
        view = CLKSwitchView(frame: NSRect(x: 0, y: 0, width: defaultUnit, height: defaultUnit))
        view.closed = state == .closed ? true : false
        super.init()

        view.delegate = self
    }
}

public enum CLKSwitchState {
    case open, closed
}

public class CLKSwitchView: NSView {
    weak var delegate: CLKSwitch!
    var closed: Bool = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSColor.white.setFill()
        dirtyRect.fill()
        
        let path = NSBezierPath()
        if closed {
            path.move(to: NSPoint(x: 0, y: defaultUnit/2))
            path.line(to: NSPoint(x: defaultUnit, y: defaultUnit/2))
            path.stroke()
        } else {
            path.move(to: NSPoint(x: 0, y: defaultUnit/2))
            path.line(to: NSPoint(x: defaultUnit/4, y: defaultUnit/2))
            path.line(to: NSPoint(x: defaultUnit/2, y: defaultUnit/4*3))
            path.stroke()
            
            path.move(to:  NSPoint(x: defaultUnit/4*3, y: defaultUnit/2))
            path.line(to: NSPoint(x: defaultUnit, y: defaultUnit/2))
            path.stroke()
        }
    }
    
    public override func mouseUp(with event: NSEvent) {
        delegate.switchState = closed ? .open : .closed
    }
}

extension CLKSwitch: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        self.view
    }
}
