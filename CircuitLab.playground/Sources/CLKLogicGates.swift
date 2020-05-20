import Foundation

public func CLKnot(input: CLKInput, output: CLKOutput) {
    switch input.getValue() {
    case .up:
        output.setValue(to: .down)
    case .down:
        output.setValue(to: .up)
    case .fuzzy:
        output.setValue(to: .fuzzy)
    }
}

public func CLKor(inputA: CLKInput, inputB: CLKInput, output: CLKOutput) {
    let valueA = inputA.getValue()
    let valueB = inputB.getValue()
    
    if valueA == .up || valueB == .up {
        output.setValue(to: .up)
    } else if valueA == .fuzzy || valueB == .fuzzy {
        output.setValue(to: .fuzzy)
    } else {
        output.setValue(to: .down)
    }
}

public func CLKand(inputA: CLKInput, inputB: CLKInput, output: CLKOutput) {
    let valueA = inputA.getValue()
    let valueB = inputB.getValue()
    
    if valueA == .up && valueB == .up {
        output.setValue(to: .up)
    } else if valueA == .down || valueB == .down {
        output.setValue(to: .down)
    } else {
        output.setValue(to: .fuzzy)
    }
}
