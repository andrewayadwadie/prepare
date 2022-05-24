import 'dart:developer';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


 
class DailyWorkAudioController extends GetxController {
  AudioPlayer playStart = AudioPlayer();
  AudioPlayer playerStrsight = AudioPlayer();
  AudioPlayer playerBeforeRight = AudioPlayer();
  AudioPlayer playerRight = AudioPlayer();
  AudioPlayer playerBeforeLeft = AudioPlayer();
  AudioPlayer playerLeft = AudioPlayer();
  AudioPlayer playerSlowSpeed = AudioPlayer();
  AudioPlayer playerStopHere = AudioPlayer();
  AudioPlayer playerwillArrive = AudioPlayer();
  @override
  void onClose() {
    playStart.dispose();
    playerStrsight.dispose();
    playerBeforeRight.dispose();
    playerRight.dispose();
    playerBeforeLeft.dispose();
    playerLeft.dispose();
    playerSlowSpeed.dispose();
    playerStopHere.dispose();
    playerwillArrive.dispose();

    super.onClose();
  }

  Future<void> playAudioStart() async {
    try {
      await playStart.setAsset('assets/audio/start_your_mission.mp3');
      playStart.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playAudioStraight() async {
    try {
      await playerStrsight.setAsset('assets/audio/go_straight_ahead.mp3');
      playerStrsight.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioBeforeRight() async {
    try {
      await playerBeforeRight
          .setAsset('assets/audio/Turn_right_after_fifty_meters.mp3');
      playerBeforeRight.play();
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

  Future<void> playerAudioBeforeLeft() async {
    try {
      await playerBeforeLeft
          .setAsset('assets/audio/Turn_left_after_fifty_meters.mp3');
      playerBeforeLeft.play();
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

  Future<void> playerAudioSlowSpeed() async {
    try {
      await playerSlowSpeed.setAsset('assets/audio/please-slow_your_speed.mp3');
      playerSlowSpeed.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioWillArrive() async {
    try {
      await playerwillArrive.setAsset(
          'assets/audio/you_will_finish_your_trip_after_fifty_meters.mp3');
      playerwillArrive.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }

  Future<void> playerAudioStopHere() async {
    try {
      await playerStopHere
          .setAsset('assets/audio/stop_here_you_finished_your_trip.mp3');
      playerStopHere.play();
    } catch (e) {
      log("can not play Audio Straight cause : $e ");
    }
  }
}
