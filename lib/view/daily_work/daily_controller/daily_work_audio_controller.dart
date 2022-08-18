import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DailyWorkAudioController extends GetxController {
  AudioPlayer player = AudioPlayer();

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  Future<void> playerAudioRight() async {
    try {
      await player.setAsset('assets/audio/take your right.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Right cause : $e ");
    }
  }

  Future<void> playerAudioLeft() async {
    try {
      await player.setAsset('assets/audio/take your left.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Left cause : $e ");
    }
  }

  Future<void> playerAudioTurnBack() async {
    try {
      await player.setAsset('assets/audio/turn back again .mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Turn Back cause : $e ");
    }
  }

  Future<void> playerAudioStart() async {
    try {
      await player.setAsset('assets/audio/start your mission .mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Start cause : $e ");
    }
  }

  Future<void> playerAudioFinish() async {
    try {
      await player.setAsset('assets/audio/You finished your Mission.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Finish cause : $e ");
    }
  }

  Future<void> playerAudioUturnLeft() async {
    try {
      await player.setAsset('assets/audio/take next uturn to left.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio ul cause : $e ");
    }
  }

  Future<void> playerAudioUturnRight() async {
    try {
      await player.setAsset('assets/audio/take next uturn to right.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Ur cause : $e ");
    }
  }

Future<void> playerAudioStraight() async {
    try {
      await player.setAsset('assets/audio/go straight ahead .mp3');
      player.play();
    } catch (e) {
      log("can not play Audio go straight ahead   cause : $e ");
    }
  }

Future<void> playerAudioUTurn() async {
    try {
      await player.setAsset('assets/audio/take the Next U turn.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio take the Next U turn cause : $e ");
    }
  }

}
