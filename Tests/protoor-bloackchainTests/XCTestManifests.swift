import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(protoor_bloackchainTests.allTests),
    ]
}
#endif
