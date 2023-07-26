import Flutter
import UIKit
import FingerprintJS

public class FlutterFingerprintjsPlugin: NSObject, FlutterPlugin {
    var fingerprinter : Fingerprinter? = nil
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_fingerprintjs", binaryMessenger: registrar.messenger())
    let instance = FlutterFingerprintjsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "init"){
          fingerprinter = FingerprinterFactory.getInstance()
          result(nil)
      } else if(call.method == "getFingerprint"){
          fingerprinter?.getFingerprint({ fingerprint in
              result(fingerprint)
          })
      } else if(call.method == "getDeviceId"){
          fingerprinter?.getDeviceId({ deviceId in
              result(deviceId)
          })
      }
  }
}
