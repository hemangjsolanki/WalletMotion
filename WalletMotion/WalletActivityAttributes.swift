import Foundation
import ActivityKit

struct WalletActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic state: e.g., the current status of the transaction
        var status: String
    }

    // Fixed non-changing properties about your activity go here!
    var cardName: String
    var cardType: String
}
