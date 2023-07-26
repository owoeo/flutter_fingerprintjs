import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fingerprintjs/flutter_fingerprintjs.dart';
import 'package:flutter_fingerprintjs/flutter_fingerprintjs_platform_interface.dart';
import 'package:flutter_fingerprintjs/flutter_fingerprintjs_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFingerprintjsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFingerprintjsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> getDeviceId() => Future.value('42');

  @override
  Future<String?> getFingerprint() => Future.value('42');

  @override
  Future<void> init() async {}
}

void main() {
  final FlutterFingerprintjsPlatform initialPlatform =
      FlutterFingerprintjsPlatform.instance;

  test('$MethodChannelFlutterFingerprintjs is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFingerprintjs>());
  });

  test('getPlatformVersion', () async {
    MockFlutterFingerprintjsPlatform fakePlatform =
        MockFlutterFingerprintjsPlatform();
    FlutterFingerprintjsPlatform.instance = fakePlatform;
    await FlutterFingerprintjs.init();
    expect(await FlutterFingerprintjs.getDeviceId(), '42');
  });
}
