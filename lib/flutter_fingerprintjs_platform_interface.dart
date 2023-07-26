import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_fingerprintjs_method_channel.dart';

abstract class FlutterFingerprintjsPlatform extends PlatformInterface {
  /// Constructs a FlutterFingerprintjsPlatform.
  FlutterFingerprintjsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFingerprintjsPlatform _instance =
      MethodChannelFlutterFingerprintjs();

  /// The default instance of [FlutterFingerprintjsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFingerprintjs].
  static FlutterFingerprintjsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFingerprintjsPlatform] when
  /// they register themselves.
  static set instance(FlutterFingerprintjsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> init() {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getFingerprint() {
    throw UnimplementedError('getFingerprint() has not been implemented.');
  }

  Future<String?> getDeviceId() {
    throw UnimplementedError('getDeviceId() has not been implemented.');
  }
}
