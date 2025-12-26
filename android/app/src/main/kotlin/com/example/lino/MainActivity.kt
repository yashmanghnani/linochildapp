package com.example.lino

import android.media.AudioManager
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "audio_manager_helper"
    private var audioManager: AudioManager? = null
    private var originalVolume: Int = 0

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "muteSystemSounds" -> {
                    audioManager?.let {
                        // Save original volume
                        originalVolume = it.getStreamVolume(AudioManager.STREAM_SYSTEM)
                        
                        // Mute system stream (where UI sounds like mic toggle play)
                        it.setStreamVolume(
                            AudioManager.STREAM_SYSTEM, 
                            0, 
                            0
                        )
                        result.success(true)
                    } ?: result.error("ERROR", "AudioManager not available", null)
                }
                "unmuteSystemSounds" -> {
                    audioManager?.let {
                        // Restore original volume
                        it.setStreamVolume(
                            AudioManager.STREAM_SYSTEM, 
                            originalVolume, 
                            0
                        )
                        result.success(true)
                    } ?: result.error("ERROR", "AudioManager not available", null)
                }
                else -> result.notImplemented()
            }
        }
    }
}