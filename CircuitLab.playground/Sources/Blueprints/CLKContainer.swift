import Cocoa

public class CLKContainer: NSView {
    let padding = 8
    let subview: NSView
    let backgroundColor = NSColor(calibratedWhite: 0.86, alpha: 1)
    
    public init(with view: NSView) {
        subview = view
        let frame = NSRect(x: 0, y: 0, width: Int(view.frame.width) + padding * 2, height: Int(view.frame.height) + padding * 2)
        super.init(frame: frame)
        self.wantsLayer = true;
        self.layer?.masksToBounds = true;
        self.layer?.cornerRadius = 4;
        subview.setFrameOrigin(NSPoint(x: padding, y: padding))
        addSubview(subview)
        becomeFirstResponder()
        menu = generateMenu()
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        backgroundColor.setFill()
        dirtyRect.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delta = NSPoint(x: 0, y: 0)
    
    public override func mouseDown(with event: NSEvent) {
        let origin = self.frame.origin
        let current = event.locationInWindow
        delta.x = current.x - origin.x
        delta.y = current.y - origin.y
    }
    
    public override func mouseDragged(with event: NSEvent) {
        var current = event.locationInWindow
        current.x -= delta.x
        current.y -= delta.y
        self.setFrameOrigin(current)
    }
    
    
    let nameItem = NSMenuItem()
    public var name = "" {
        didSet {
            nameItem.title = name
        }
    }
    func generateMenu() -> NSMenu {
        let menu = NSMenu()
        nameItem.isEnabled = false
        menu.addItem(nameItem)
        
        return menu
    }
}
