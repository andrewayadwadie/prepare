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

  Future<void> playerAudioTurnBack() async {
    try {
      await player.setAsset('assets/audio/turn_back.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Turn Back cause : $e ");
    }
  }

  Future<void> playerAudioStart() async {
    try {
      await player.setAsset('assets/audio/start_your_mission.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Start cause : $e ");
    }
  }

  Future<void> playerAudioFinish() async {
    try {
      await player
          .setAsset('assets/audio/stop_here_you_finished_your_trip.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Finish cause : $e ");
    }
  }

  Future<void> playerAudioUturnLeft() async {
    try {
      await player.setAsset('assets/audio/turn_left.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio ul cause : $e ");
    }
  }

  Future<void> playerAudioUturnRight() async {
    try {
      await player.setAsset('assets/audio/turn_right.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio Ur cause : $e ");
    }
  }

  Future<void> playerAudioStraight() async {
    try {
      await player.setAsset('assets/audio/go_straight.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio go straight ahead   cause : $e ");
    }
  }

  Future<void> playerAudioUTurn() async {
    try {
      await player.setAsset('assets/audio/take_the_next_turn.mp3');
      player.play();
    } catch (e) {
      log("can not play Audio take the Next U turn cause : $e ");
    }
  }
}
