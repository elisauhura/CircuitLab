import Cocoa

public let defaultUnit = 32
public let defaultColor: NSColor = .gray

/// CLKState is used to represent logical states
public enum CLKState {
    /// .up represents the true state
    case up
    /// .down represents the false state
    case down
    /// .fuzzy represents an unknown state
    case fuzzy
}

/// CLKInput means that the value may be used as input in the circuit
public protocol CLKInput {
    /// Retrieves the state of the value
    func getValue() -> CLKState
}
/// CLKOutput means that the value may be used as output in the circuit
public protocol CLKOutput {
    func setValue(to state: CLKState)
}

/// Value conforms to CLKInput and CLKOutput
public protocol CLKIO: CLKInput, CLKOutput { }
