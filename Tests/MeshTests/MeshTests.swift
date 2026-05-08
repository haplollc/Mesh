import XCTest
@testable import Mesh

final class MeshTests: XCTestCase {
    func testVersionIsNonEmpty() {
        XCTAssertFalse(Mesh.version.isEmpty)
    }
}
