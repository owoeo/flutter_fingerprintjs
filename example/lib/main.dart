import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_fingerprintjs/flutter_fingerprintjs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _fingerprint = 'Unknown';
  String _deviceId = 'Unknown';

  @override
  void initState() {
    super.initState();
    FlutterFingerprintjs.init().then((value) => initPlatformState());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String fingerprint, deviceId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      fingerprint = await FlutterFingerprintjs.getFingerprint() ??
          'Unknown platform version';
    } on PlatformException {
      fingerprint = 'Failed to get platform version.';
    }

    try {
      deviceId = await FlutterFingerprintjs.getDeviceId() ??
          'Unknown platform version';
    } on PlatformException {
      deviceId = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _fingerprint = fingerprint;
      _deviceId = deviceId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_fingerprint\n'),
              Text('Running on: $_deviceId\n'),
            ],
          ),
        ),
      ),
    );
  }
}
