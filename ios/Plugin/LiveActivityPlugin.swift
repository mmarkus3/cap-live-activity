import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(LiveActivityPlugin)
public class LiveActivityPlugin: CAPPlugin {
    private let implementation = LiveActivity()

    @objc func start(_ call: CAPPluginCall) {
        if #available(iOS 16.1, *) {
            let name = call.getString("name") ?? ""
            let start = call.getDate("start") ?? Date.now
            call.resolve([
                "value": implementation.start(name, start)
            ])
        } else {
            call.unavailable("Not available in iOS 16 or earlier.")
        }
    }
}
