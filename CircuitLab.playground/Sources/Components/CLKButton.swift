import Cocoa

public class CLKButton: CLKWire {
    // properties
    public var view: CLKButtonView
    
    public override var state: CLKState {
        didSet {
            if state == .up {
                view.pressed = true
            } else {
                view.pressed = false
            }
        }
    }
    
    // methods
    public init(at state: CLKState) {
        view = CLKButtonView(frame: NSRect(x: 0, y: 0, width: defaultUnit, height: defaultUnit))
        super.init()
        
        view.button = self
        self.state = state
    }
}

public class CLKButtonView: NSView {
    let buttonPressed = NSImage(named: "ButtonPressed")!
    let buttonUnpressed = NSImage(named: "ButtonUnpressed")!
    let imageView: NSImageView
    weak var button: CLKButton!
    var pressed: Bool = false {
        didSet {
            if pressed {
                imageView.image = buttonPressed
            } else {
                imageView.image = buttonUnpressed
            }
        }
    }
    
    override init(frame: NSRect) {
        imageView = NSImageView(frame: frame)
        super.init(frame: frame)
        addSubview(imageView)
        imageView.image = buttonUnpressed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func mouseUp(with event: NSEvent) {
        button.state = pressed ? CLKState.down : CLKState.up
    }
}

extension CLKButton: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        self.view
    }
}
