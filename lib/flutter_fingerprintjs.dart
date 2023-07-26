import 'flutter_fingerprintjs_platform_interface.dart';

class FlutterFingerprintjs {
  static Future<void> init() {
    return FlutterFingerprintjsPlatform.instance.init();
  }

  static Future<String?> getFingerprint() {
    return FlutterFingerprintjsPlatform.instance.getFingerprint();
  }

  static Future<String?> getDeviceId() {
    return FlutterFingerprintjsPlatform.instance.getDeviceId();
  }
}
