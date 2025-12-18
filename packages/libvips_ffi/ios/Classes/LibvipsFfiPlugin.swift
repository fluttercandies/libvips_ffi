import Flutter
import UIKit

public class LibvipsFfiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    // No method channel needed - this plugin only provides native libraries via FFI
  }
}
