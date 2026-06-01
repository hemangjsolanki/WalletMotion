import ActivityKit
import WidgetKit
import SwiftUI
//
//struct WalletActivityAttributes: ActivityAttributes {
//    public struct ContentState: Codable, Hashable {
//        var status: String
//    }
//    var cardName: String
//    var cardType: String
//}

//@available(iOS 16.1, *)
//struct WalletWidgetLiveActivity: Widget {
//    var body: some WidgetConfiguration {
//        ActivityConfiguration(for: WalletActivityAttributes.self) { context in
//            // Lock screen/banner UI
//            VStack {
//                HStack(spacing: 16) {
//                    ZStack {
//                        Circle()
//                            .fill(LinearGradient(colors: [.green.opacity(0.8), .green.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
//                            .frame(width: 50, height: 50)
//                            .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 5)
//                        
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 24, weight: .bold))
//                            .foregroundColor(.white)
//                    }
//                    
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(context.state.status.uppercased())
//                            .font(.system(size: 14, weight: .black, design: .rounded))
//                            .foregroundColor(.green)
//                            .shadow(color: .green.opacity(0.3), radius: 5, x: 0, y: 0)
//                        
//                        Text("\(context.attributes.cardType) • \(context.attributes.cardName)")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                            .foregroundColor(.white.opacity(0.9))
//                    }
//                    Spacer()
//                    
//                    Image(systemName: "faceid")
//                        .font(.system(size: 38, weight: .light))
//                        .symbolRenderingMode(.hierarchical)
//                        .foregroundColor(.green)
//                }
//                .padding()
//            }
//            .activityBackgroundTint(Color.black.opacity(0.6))
//            .activitySystemActionForegroundColor(Color.white)
//
//        } dynamicIsland: { context in
//            DynamicIsland {
//                // Expanded UI
//                DynamicIslandExpandedRegion(.leading) {
//                    HStack(spacing: 8) {
//                        ZStack {
//                            Circle()
//                                .fill(Color.green.opacity(0.2))
//                                .frame(width: 40, height: 40)
//                            Image(systemName: "checkmark.circle.fill")
//                                .font(.system(size: 28))
//                                .foregroundColor(.green)
//                        }
//                    }
//                    .padding(.top, 5)
//                    .padding(.leading, 5)
//                }
//                
//                DynamicIslandExpandedRegion(.trailing) {
//                    Image(systemName: "faceid")
//                        .font(.system(size: 34, weight: .light))
//                        .symbolRenderingMode(.hierarchical)
//                        .foregroundColor(.green)
//                        .padding(.top, 5)
//                        .padding(.trailing, 5)
//                }
//                
//                DynamicIslandExpandedRegion(.bottom) {
//                    VStack(alignment: .center, spacing: 6) {
//                        Text(context.state.status.uppercased())
//                            .font(.system(size: 14, weight: .black, design: .rounded))
//                            .foregroundColor(.green)
//                            // Glowing text effect in the island
//                            .shadow(color: .green.opacity(0.8), radius: 10, x: 0, y: 0)
//                        
//                        Text("\(context.attributes.cardType) • \(context.attributes.cardName)")
//                            .font(.subheadline)
//                            .fontWeight(.bold)
//                            .foregroundColor(.white)
//                    }
//                    .padding(.bottom, 15)
//                }
//            } compactLeading: {
//                Image(systemName: "creditcard.fill")
//                    .foregroundColor(.green)
//            } compactTrailing: {
//                Image(systemName: "faceid")
//                    .foregroundColor(.green)
//            } minimal: {
//                Image(systemName: "checkmark.circle.fill")
//                    .foregroundColor(.green)
//            }
//            .keylineTint(Color.green.opacity(0.5))
//        }
//    }
//}
