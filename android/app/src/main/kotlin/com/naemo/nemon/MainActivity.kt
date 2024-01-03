package com.naemo.nemon

import android.os.Build
import io.flutter.embedding.android.FlutterActivity


import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.shovving_pre"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                    if (call.method == "clearClipboard") {
                        val clipboardManager =
                                getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
                        clipboardManager.setPrimaryClip(ClipData.newPlainText("", ""))
                        result.success(null)
                    } else {
                        result.notImplemented()
                    }
                }
    }

}
