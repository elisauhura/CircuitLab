import Cocoa

public class CLKViewPair: NSView {
    public init(_ viewA: NSView, _ viewB: NSView) {
        super.init(
            frame: NSRect(
                x: 0,
                y: 0,
                width: viewA.frame.width + viewB.frame.width,
                height: max(viewA.frame.height, viewB.frame.height)
            ))
        viewA.setFrameOrigin(NSPoint(x: 0, y: 0))
        viewB.setFrameOrigin(NSPoint(x: viewA.frame.width, y: 0))
        addSubview(viewA)
        addSubview(viewB)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func from(array views: [NSView]) -> NSView {
        var view: NSView? = nil
        for i in (0..<views.count).reversed() {
            if view != nil {
                view = CLKViewPair(views[i], view!)
            } else {
                view = views[i]
            }
        }
        return view!
    }
}
