import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_fingerprintjs_platform_interface.dart';

/// An implementation of [FlutterFingerprintjsPlatform] that uses method channels.
class MethodChannelFlutterFingerprintjs extends FlutterFingerprintjsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_fingerprintjs');

  @override
  Future<void> init() {
    return methodChannel.invokeMethod<void>('init');
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getDeviceId() async {
    final result = await methodChannel.invokeMethod<String>('getDeviceId');
    return result;
  }

  @override
  Future<String?> getFingerprint() async {
    final result = await methodChannel.invokeMethod<String>('getFingerprint');
    return result;
  }
}
