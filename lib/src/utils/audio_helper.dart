
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class AudioManagerHelper {
  static const MethodChannel _channel = MethodChannel('audio_manager_helper');

  // 🔥 Mute system sounds (including speech recognition beeps)
  static Future<void> muteSystemSounds() async {
    try {
      await _channel.invokeMethod('muteSystemSounds');
      debugPrint("🔇 System sounds muted");
    } catch (e) {
      debugPrint("❌ Failed to mute system sounds: $e");
    }
  }

  // 🔥 Unmute system sounds
  static Future<void> unmuteSystemSounds() async {
    try {
      await _channel.invokeMethod('unmuteSystemSounds');
      debugPrint("🔊 System sounds unmuted");
    } catch (e) {
      debugPrint("❌ Failed to unmute system sounds: $e");
    }
  }
}
