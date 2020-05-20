import Foundation

public class CLKConstant: CLKInput {
    let state: CLKState
    
    public init(to state: CLKState) {
        self.state = state
    }
    
    public func getValue() -> CLKState {
        return state
    }
}
