import Cocoa

public class CLKBench: NSView {
    let background = NSImage(named: "Tile")!
    
    public override init(frame: NSRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ dirtyRect: NSRect) {
        NSColor.init(patternImage: background).setFill()
        dirtyRect.fill()
    }
    
    public override func mouseDragged(with event: NSEvent) {
    }
    
    public func add(component: NSView, named: String, x: Int = 0, y: Int = 0) {
        let container = CLKContainer(with: component)
        container.name = named
        container.setFrameOrigin(NSPoint(x: x, y: y))
        self.addSubview(container)
    }
}
