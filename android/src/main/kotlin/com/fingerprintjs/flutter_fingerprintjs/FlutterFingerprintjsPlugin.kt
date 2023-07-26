package com.fingerprintjs.flutter_fingerprintjs

import android.content.Context
import android.os.Handler
import androidx.annotation.NonNull
import com.fingerprintjs.android.fingerprint.Fingerprinter
import com.fingerprintjs.android.fingerprint.FingerprinterFactory

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterFingerprintjsPlugin */
class FlutterFingerprintjsPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var fingerprinter: Fingerprinter? = null
    private lateinit var context: Context
    private lateinit var handler: Handler

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        handler = Handler(context.mainLooper)
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_fingerprintjs")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else if (call.method == "init") {
            if (fingerprinter == null) {
                fingerprinter = FingerprinterFactory.create(context)
            }
            result.success(null)
        } else if (call.method == "getFingerprint") {
            getFingerprint(result)
        } else if (call.method == "getDeviceId") {
            getDeviceId(result)
        } else {
            result.notImplemented()
        }
    }

    private fun getFingerprint(result: Result) {
        if (fingerprinter == null) {
            result.error("-1", "init must be called first", "init must be called first")
            return
        }
        fingerprinter?.getFingerprint(version = Fingerprinter.Version.V_5) { fingerprint ->
            handler.post { result.success(fingerprint) }
        }
    }

    private fun getDeviceId(result: Result) {
        if (fingerprinter == null) {
            result.error("-1", "init must be called first", "init must be called first")
            return
        }
        fingerprinter?.getDeviceId(version = Fingerprinter.Version.V_5) { info ->
            handler.post { result.success(info.deviceId) }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
