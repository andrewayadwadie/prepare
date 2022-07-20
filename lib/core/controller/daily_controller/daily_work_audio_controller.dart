import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class DailyWorkAudioController extends GetxController {
  AudioPlayer playerStraight = AudioPlayer();
  AudioPlayer playerRight = AudioPlayer();
  AudioPlayer playerLeft = AudioPlayer();
  AudioPlayer playerTurnBack = AudioPlayer();
  AudioPlayer playerForward = AudioPlayer();

  @override
  void onClose() {
    playerStraight.dispose();
    playerRight.dispose();
    playerLeft.dispose();
    playerForward.dispose();
    playerTurnBack.dispose();
    super.onClose();
  }

  Future<void> playAudioStraight() async {
    try {
      await playerStraight.setAsset('assets/audio/go_straight.mp3');
      playerStraight.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioRight() async {
    try {
      await playerRight.setAsset('assets/audio/turn_right.mp3');
      playerRight.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioLeft() async {
    try {
      await playerLeft.setAsset('assets/audio/turn_left.mp3');
      playerLeft.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioTurnBack() async {
    try {
      await playerTurnBack.setAsset('assets/audio/turn_back.mp3');
      playerTurnBack.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioTurnForward() async {
    try {
      await playerForward.setAsset('assets/audio/take_the_next_turn.mp3');
      playerForward.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }
}
