import Cocoa
import FlutterMacOS

public class AppBadgePlusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_badge_plus", binaryMessenger: registrar.messenger)
    let instance = AppBadgePlusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "updateBadge":
        let args = call.arguments as? Dictionary<String, Any>
        let count = (args?["count"] as? Int) ?? 0
        DispatchQueue.main.async {
          if count > 0 {
            NSApplication.shared.dockTile.badgeLabel = "\(count)"
          } else {
            let dockTile = NSApplication.shared.dockTile
            dockTile.badgeLabel = nil
            dockTile.display() // 강제로 업데이트
          }
        }
        result(nil)
      case "isSupported":
        result(true)
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
