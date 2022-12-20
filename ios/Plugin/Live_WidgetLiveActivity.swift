//
//  Live_WidgetLiveActivity.swift
//  Live-Widget
//
//  Created by Markus Montonen on 20.12.2022.
//  Copyright © 2022 Scandium. All rights reserved.
//

import ActivityKit
import WidgetKit
import SwiftUI

@available(iOS 16.1, *)
@main
struct Widgets: WidgetBundle {
   var body: some Widget {
       Live_WidgetLiveActivity()
   }
}

struct Live_WidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var value: ClosedRange<Date>
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

@available(iOS 16.1, *)
struct Live_WidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: Live_WidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Spacer()
                Text(context.attributes.name)
                Spacer()
                HStack {
                    Spacer()
                    Label {
                        Text(timerInterval: context.state.value, countsDown: true)
                            .multilineTextAlignment(.center)
                            .frame(width: 50)
                            .monospacedDigit()
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.blue)
                    }
                    .font(.title2)
                    Spacer()
                }
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Label {
                        
                    } icon: {
                        Image(systemName: "timer")
                            .foregroundColor(.blue)
                    }
                    .padding(.leading)
                    .font(.title2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timerInterval: context.state.value, countsDown: true)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 60)
                        .monospacedDigit()
                        .font(.title2)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Label {
                        Text(context.attributes.name)
                            .padding(.leading)
                    } icon: {
                        Image(systemName: "carrot")
                            .foregroundColor(.orange)
                    }
                }
            } compactLeading: {
                Label {
                    Text(context.attributes.name)
                } icon: {
                    Image(systemName: "carrot")
                        .foregroundColor(.orange)
                }
                .font(.caption2)
            } compactTrailing: {
                Label {
                    Text(timerInterval: context.state.value, countsDown: true)
                        .multilineTextAlignment(.center)
                        .frame(width: 40)
                        .font(.caption2)
                } icon: {
                    Image(systemName: "timer")
                        .foregroundColor(.blue)
                }
            } minimal: {
                VStack(alignment: .center) {
                    Text(timerInterval: context.state.value, countsDown: true)
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                        .font(.caption2)
                }
            }
            .keylineTint(Color.red)
        }
    }
}

struct Live_WidgetLiveActivity_Previews: PreviewProvider {
    static var timeClosedRange: ClosedRange<Date> {
        var minute: Int { Calendar.current.component(.minute, from: Date()) }
        let min = Date()
        let max = Calendar.current.nextDate(after: Date(), matching: DateComponents(minute: minute >= 30 ? 0 : 30), matchingPolicy: .strict)!
        return min...max
    }
    
    static let attributes = Live_WidgetAttributes(name:"Ruokatauko")
    static let contentState = Live_WidgetAttributes.ContentState(value: timeClosedRange)

    static var previews: some View {
        if #available(iOS 16.2, *) {
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Island Compact")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 16.2, *) {
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Island Expanded")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 16.2, *) {
            attributes
                .previewContext(contentState, viewKind: .dynamicIsland(.minimal))
                .previewDisplayName("Minimal")
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 16.2, *) {
            attributes
                .previewContext(contentState, viewKind: .content)
                .previewDisplayName("Notification")
        } else {
            // Fallback on earlier versions
        }
    }
}
