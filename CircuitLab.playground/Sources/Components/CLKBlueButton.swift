import Cocoa

public class CLKBlueButton: CLKWire {
    // properties
    public var view: CLKBlueButtonView
    
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
    public override init() {
        view = CLKBlueButtonView(frame: NSRect(x: 0, y: 0, width: defaultUnit, height: defaultUnit))
        super.init()
        
        view.button = self
        self.state = .down
    }
}

public class CLKBlueButtonView: NSView {
    let buttonPressed = NSImage(named: "BlueButtonPressed")!
    let buttonUnpressed = NSImage(named: "BlueButtonUnpressed")!
    let imageView: NSImageView
    weak var button: CLKBlueButton!
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
    
    var timer: Timer? = nil
    
    public override func mouseDown(with event: NSEvent) {
        if let t = timer { t.invalidate(); timer = nil}
        button.state = CLKState.up
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) {
            _ in
            self.button.state = CLKState.down
        }
    }
}

extension CLKBlueButton: CustomPlaygroundDisplayConvertible {
    public var playgroundDescription: Any {
        self.view
    }
}

