import Foundation
import ActivityKit
import WidgetKit

@objc public class LiveActivity: NSObject {
    @objc public func start(_ name: String, _ start: Date) -> String {
        if #available(iOS 16.2, *) {
            let minutes = 30;
            
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                let future = Calendar.current.date(byAdding: .minute, value: (Int(minutes)), to: Date())!
                let date = start...future
                let initialContentState = Live_WidgetAttributes.ContentState(value:date)
                let activityAttributes = Live_WidgetAttributes(name: name)
                
                let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: minutes, to: Date())!)
                do {
                    let liveActivity = try Activity<Live_WidgetAttributes>.request(attributes: activityAttributes, content: activityContent, pushType: nil)
                    print("Requested Live Activity \(String(describing: liveActivity.id)).")
                    return liveActivity.id
                } catch (let error) {
                    print("Error requesting Live Activity \(error.localizedDescription).")
                    return error.localizedDescription
                }
            }
        } else {
            // Fallback on earlier versions
            return "Not available"
        }
        return name
    }
}
