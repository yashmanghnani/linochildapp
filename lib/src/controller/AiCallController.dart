// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:lino/src/utils/audio_helper.dart';
import 'package:lino/src/view/widgets/app_Audio_Service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lino/src/model/repository/Repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:state_extended/state_extended.dart';
// 🔥 Import audio manager helper (if you implement it)
// import 'package:lino/src/utils/audio_manager_helper.dart';

class Aicallcontroller extends StateXController {
  // 🔥 SINGLETON PATTERN - ensures only one instance exists
  static final Aicallcontroller _instance = Aicallcontroller._internal();
  factory Aicallcontroller() => _instance;
  Aicallcontroller._internal();

  final Repository _repository = Repository();

  bool isLoading = false;
  bool? result;
  IO.Socket? socket;
  bool micEnabled = true;
  bool isAISpeaking = false;
  bool waitingForFinalResult = false;

  final AudioPlayer _player = AudioPlayer();
  final SpeechToText _speech = SpeechToText();
  bool speechReady = false;
  String recognizedText = "";

  bool _socketInitialized = false;

  bool incomingCall = false;
  bool inCall = false;
  bool isRecording = false;

  String aiText = "";
  DateTime? lastSpeechTime;

  // 🔥 Track current user to prevent multiple calls
  String? _currentUserId;

  // 🔥 Prevent double shutdown
  bool _isShuttingDown = false;

  // 🔥 Track if we should ignore socket events (during shutdown)
  bool _ignoreSocketEvents = false;

  Future<void> callAi(String user) async {
    debugPrint("🚀 API CALL STARTED for user: $user");

    try {
      result = await _repository.AiCall(user);
      debugPrint("✅ API RESPONSE: $result");
    } catch (e) {
      debugPrint("❌ API ERROR: $e");
      rethrow;
    }
  }

  Future<void> initSpeech() async {
    if (speechReady) {
      debugPrint("✅ Speech already initialized");
      return;
    }

    speechReady = await _speech.initialize(
      onStatus: (status) {
        debugPrint("🎙️ STATUS: $status");
        // 🔥 Ignore status changes during shutdown
        if (_ignoreSocketEvents) return;
      },
      onError: (error) {
        debugPrint("❌ SPEECH ERROR: $error");
        if (!_ignoreSocketEvents) {
          waitingForFinalResult = false;
        }
      },
      // 🔥 Disable the annoying beep sounds
      options: [SpeechToText.androidIntentLookup],
    );
  }

  Future<void> startContinuousListening() async {
    // 🔥 Don't start if shutting down
    if (_isShuttingDown || _ignoreSocketEvents) {
      debugPrint("🎙️ Ignoring listen request (shutting down)");
      return;
    }

    if (isAISpeaking) {
      debugPrint("🎙️ Mic blocked (AI speaking)");
      return;
    }

    if (!micEnabled) {
      debugPrint("🎙️ Mic disabled by user");
      return;
    }

    if (_speech.isListening) {
      debugPrint("🎙️ Already listening");
      return;
    }

    recognizedText = "";
    waitingForFinalResult = true;

    try {
      await _speech.listen(
        listenMode: ListenMode.dictation,
        partialResults: true,
        pauseFor: const Duration(seconds: 4),
        listenFor: const Duration(
          minutes: 10,
        ), // 🔥 Extended to 10 minutes to reduce restarts
        onResult: (result) {
          // 🔥 Ignore results during shutdown
          if (_ignoreSocketEvents) return;

          recognizedText = result.recognizedWords;

          debugPrint(
            "🗣️ USER: ${result.recognizedWords} | final=${result.finalResult}",
          );

          if (result.finalResult && recognizedText.trim().isNotEmpty) {
            stopAndSendText();
          }
        },
        // 🔥 Additional options to suppress sounds
        onSoundLevelChange: null, // Disable sound level monitoring
        cancelOnError: false,
        listenOptions: SpeechListenOptions(
          // 🔥 Disable system sounds
          autoPunctuation: true,
          enableHapticFeedback: false,
        ),
      );

      setState(() => isRecording = true);
    } catch (e) {
      debugPrint("❌ Listen error: $e");
    }
  }

  Future<void> stopAndSendText() async {
    if (_ignoreSocketEvents || isAISpeaking) {
      debugPrint("🚫 Not sending (shutting down or AI speaking)");
      return;
    }

    if (!waitingForFinalResult) return;
    waitingForFinalResult = false;

    // 🔥 DON'T stop listening - just keep it running
    // This prevents the annoying beep sound
    // Only stop if text is too short
    final text = recognizedText.trim();

    setState(() => isRecording = true); // Keep showing as recording

    if (text.length < 3) {
      // Don't restart - already listening
      return;
    }

    socket?.emit("human_text", {"text": text});
    debugPrint("📤 SENT: $text");

    // 🔥 Clear text but keep listening
    recognizedText = "";
    waitingForFinalResult = true;
  }

  void initSocket(String userId) {
    if (_socketInitialized && socket != null && socket!.connected) {
      debugPrint("✅ Socket already connected");
      return;
    }

    // 🔥 Clean up old socket if exists
    if (socket != null) {
      try {
        socket!.dispose();
      } catch (e) {
        debugPrint("⚠️ Socket dispose error: $e");
      }
      socket = null;
    }

    _socketInitialized = true;
    _currentUserId = userId;
    _ignoreSocketEvents = false; // 🔥 Reset flag

    socket = IO.io(
      'http://technoparticles.cloud:4000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setReconnectionDelay(2000)
          .setReconnectionDelayMax(5000)
          .build(),
    );

    socket!.onConnect((_) async {
      // 🔥 Ignore if we're shutting down
      if (_ignoreSocketEvents) {
        debugPrint("🔌 Socket connected but ignoring (shutdown in progress)");
        return;
      }

      debugPrint("🔌 SOCKET CONNECTED");

      socket!.emit('register', userId);
      socket!.emit('ai_call_accepted');

      inCall = true;
      micEnabled = true;
      setState(() {});

      await Future.delayed(const Duration(milliseconds: 500));
      await startContinuousListening();
    });

    socket!.onDisconnect((_) {
      // 🔥 Only log and update state once
      if (!_ignoreSocketEvents) {
        debugPrint("🔌 SOCKET DISCONNECTED");
        inCall = false;
        setState(() {});
      }
    });

    socket!.on("ai_voice", (data) async {
      // 🔥 Ignore if shutting down
      if (_ignoreSocketEvents) {
        debugPrint("🤖 Ignoring AI voice (shutting down)");
        return;
      }

      aiText = data['text']?.toString() ?? "";
      final audio = data['audio'];

      if (audio == null || audio.toString().isEmpty) {
        debugPrint("⚠️ AI audio is null or empty");
        isAISpeaking = false;
        return;
      }

      debugPrint(
        "🤖 AI START SPEAKING: ${aiText.length > 50 ? aiText.substring(0, 50) : aiText}...",
      );
      isAISpeaking = true;

      // 🔥 Stop mic SILENTLY - don't restart after
      if (_speech.isListening) {
        await _speech.stop();
        setState(() => isRecording = false);
      }

      await playAIVoice(audio.toString());

      // 🔥 Check if we're still in call before restarting mic
      if (_ignoreSocketEvents || !inCall) {
        debugPrint("🤖 Not restarting mic (call ended)");
        isAISpeaking = false;
        return;
      }

      debugPrint("🤖 AI FINISHED SPEAKING");
      isAISpeaking = false;

      // 🔥 Longer delay before restarting mic to make transition smoother
      if (micEnabled && inCall) {
        await Future.delayed(const Duration(milliseconds: 800));
        startContinuousListening();
      }

      setState(() {});
    });

    socket!.connect();
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception("Microphone permission denied");
    }
  }

  Future<void> playAIVoice(String base64Audio) async {
    try {
      final bytes = base64Decode(base64Audio);
      debugPrint("🔊 Audio size: ${bytes.length} bytes");

      final dir = await getTemporaryDirectory();
      final file = File(
        "${dir.path}/ai_${DateTime.now().millisecondsSinceEpoch}.mp3",
      );

      await file.writeAsBytes(bytes, flush: true);

      await _player.setFilePath(file.path);
      await _player.play();

      // 🔥 WAIT UNTIL AUDIO FINISHES or shutdown starts
      await _player.playerStateStream.firstWhere(
        (state) =>
            state.processingState == ProcessingState.completed ||
            _ignoreSocketEvents,
      );

      debugPrint("🔊 Playback completed");

      // 🔥 Clean up temp file
      try {
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        debugPrint("⚠️ Could not delete temp file: $e");
      }
    } catch (e) {
      debugPrint("❌ Audio error: $e");
      isAISpeaking = false;
    }
  }

  void endCall(BuildContext context) async {
    await shutdownAI();
    AppAudioService().startBackgroundSound();
    Navigator.pop(context);
  }

  Future<bool> startDirectAICall(String userId) async {
    // 🔥 Prevent duplicate calls
    if (_currentUserId == userId &&
        socket != null &&
        socket!.connected &&
        !_isShuttingDown) {
      debugPrint("✅ Already connected to $userId");
      return true;
    }

    try {
      isLoading = true;
      setState(() {});

      // 🔥 Clean up previous session
      await shutdownAI();
      await AppAudioService().stopBackgroundSound();

      // 🔥 MUTE SYSTEM SOUNDS (if you implemented AudioManagerHelper)
      await AudioManagerHelper.muteSystemSounds();

      // Small delay to ensure cleanup is complete
      await Future.delayed(const Duration(milliseconds: 300));

      // 1️⃣ Hit API
      await callAi(userId);

      // 2️⃣ Init mic permission
      await initRecorder();

      // 3️⃣ Init speech
      await initSpeech();

      // 4️⃣ Init socket (this connects automatically)
      initSocket(userId);

      // 5️⃣ Wait for socket to connect
      int attempts = 0;
      while (socket == null || !socket!.connected) {
        if (attempts > 50) {
          // 5 seconds max
          throw Exception("Socket connection timeout");
        }
        await Future.delayed(const Duration(milliseconds: 100));
        attempts++;
      }

      debugPrint("✅ AI Call fully initialized");
      return true;
    } catch (e) {
      debugPrint("❌ Direct AI call error: $e");
      await shutdownAI();
      return false;
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  Future<void> shutdownAI() async {
    // 🔥 Prevent double shutdown
    if (_isShuttingDown) {
      debugPrint("⚠️ Shutdown already in progress");
      return;
    }

    _isShuttingDown = true;
    _ignoreSocketEvents = true; // 🔥 Ignore all socket events from now on

    debugPrint("🛑 Shutting down AI...");

    try {
      // 🔥 UNMUTE SYSTEM SOUNDS (if you implemented AudioManagerHelper)
      await AudioManagerHelper.unmuteSystemSounds();

      // 🛑 Stop speech recognition first
      if (_speech.isListening) {
        await _speech.stop();
        // Give it time to fully stop
        await Future.delayed(const Duration(milliseconds: 200));
      }

      // 🔇 Stop audio playback
      if (_player.playing) {
        await _player.stop();
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // 🔌 Close socket with proper cleanup
      if (socket != null) {
        try {
          socket!.emit("end_call");
          await Future.delayed(
            const Duration(milliseconds: 300),
          ); // Give time for emit
          socket!.disconnect();
          socket!.dispose();
        } catch (e) {
          debugPrint("⚠️ Socket cleanup error: $e");
        }
        socket = null;
      }

      // 🔄 Reset flags
      _socketInitialized = false;
      isAISpeaking = false;
      waitingForFinalResult = false;
      isRecording = false;
      inCall = false;
      incomingCall = false;
      recognizedText = "";
      aiText = "";
      _currentUserId = null;

      setState(() {});

      debugPrint("✅ Shutdown complete");
    } finally {
      // 🔥 Reset shutdown flags after a delay
      await Future.delayed(const Duration(milliseconds: 500));
      _isShuttingDown = false;
      _ignoreSocketEvents = false;
    }
  }

  @override
  void dispose() {
    debugPrint(
      "🧹 CLEANUP AICallController (dispose called - should not happen with singleton)",
    );

    // Synchronous cleanup only
    if (_player.playing) {
      _player.stop();
    }

    if (_speech.isListening) {
      _speech.stop();
    }

    try {
      socket?.dispose();
    } catch (e) {
      debugPrint("⚠️ Socket dispose error: $e");
    }

    super.dispose();
  }
}
