import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/data/model/music_model.dart';

import '../../theme/utils/my_strings.dart';

class MusicController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final VelocityTracker velocityTracker =
      VelocityTracker.withKind(PointerDeviceKind.touch);
  double startX = 0;
  double currentX = 0;
  Timer? songTimer;

  void handleHorizontalDragUpdate(DragUpdateDetails details) {
    currentX += details.delta.dx;
    double dx = currentX - startX;
    if (songTimer != null && songTimer!.isActive) {
      songTimer!.cancel();
    }
    const duration = Duration(milliseconds: 500);
    songTimer = Timer(duration, () {
      if (dx > 0) {
        nextSong();
      } else if (dx < 0) {
        previousSong();
      }
    });
  }

  late AnimationController _animationController;
  AnimationController get animationController => _animationController;
  // RxBool isPressed = false.obs;

  // void togglePressed() {
  //   isPressed.value = !isPressed.value;
  // }

  // void toggleAnimation() {
  //   if (_animationController.isCompleted) {
  //     _animationController.reverse();
  //   } else {
  //     _animationController.forward();
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((Duration d) {
      duration.value = d;
    });
    audioPlayer.onPositionChanged.listen((Duration p) {
      position.value = p;
    });
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        isPlaying.value = true;
      } else if (state == PlayerState.completed) {
        if (currentSongIndex.value == playlist.length - 1) {
          isPlaying.value = false;
          audioPlayer.stop();
        } else {
          nextSong();
        }
      }
    });
    audioPlayer.onPositionChanged.listen((Duration position) {
      updateLyrics(position);
    });
    initializeLyrics();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    _animationController.dispose();

    super.onClose();
  }

  List<Music> playlist = [
    Music(
      title: 'Hypotheticals',
      artist: 'Fran Vasilic',
      image: 'franvasilic',
      musicMP3: 'audio/hypotheticals.mp3',
      lyrics: MyStrings.lyrics,
    ),
    Music(
      title: 'In the stars',
      artist: 'Benson Boone',
      image: 'in_the_stars',
      musicMP3: 'audio/in_the_stars_speed_up.mp3',
      lyrics: '',
    ),
    Music(
      title: 'Never love again',
      artist: 'Eminem',
      image: 'eminem',
      musicMP3: 'audio/never_love_again.mp3',
      lyrics: '',
    ),
    Music(
      title: 'Fairy tale',
      artist: 'Alexander Rybak',
      image: 'alexander',
      musicMP3: 'audio/fairy_tale.mp3',
      lyrics: '',
    ),
    Music(
      title: 'Coming For You',
      artist: 'Switchotr',
      image: 'coming',
      musicMP3: 'audio/coming_for_you.mp3',
      lyrics: '',
    ),
    Music(
      title: 'All girl are the same',
      artist: 'Juice World',
      image: 'world',
      musicMP3: 'audio/all_girl_are_the_same.mp3',
      lyrics: '',
    ),
    Music(
      title: 'How Do I Say Goodbye - Nightcore',
      artist: 'Dean Lewis',
      image: 'lewis',
      musicMP3: 'audio/how_do_i_says_goodbye.mp3',
      lyrics: '',
    ),
  ];
  RxDouble playbackPosition = 0.0.obs;
  void updatePlaybackPosition(double value) {
    playbackPosition.value = value;
    updatePlaybackPosition(value);
  }

  var currentSongIndex = 0.obs;
  final RxInt currentLyricsIndex = 0.obs;
  final RxString currentLyrics = RxString("");
  late AudioPlayer audioPlayer;
  final RxBool isPlaying = false.obs;

  final Rx<Duration> duration = Rx<Duration>(Duration.zero);
  final Rx<Duration> position = Rx<Duration>(Duration.zero);

  void setPlaylist(List<Music> newPlaylist) async {
    playlist = newPlaylist;
    currentSongIndex = 0.obs;
    currentLyrics.value = playlist[currentSongIndex.value].lyrics;
    playAudioFromAsset();
  }

  void playAudioFromAsset() async {
    // await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setSourceAsset(playlist[currentSongIndex.value].musicMP3);
    await audioPlayer.setVolume(1.0);

    await audioPlayer.resume();
  }

  void nextSong() {
    currentSongIndex.value = ((currentSongIndex.value + 1) % playlist.length);
    if (currentSongIndex.value == 3) {
      return playAudioFromAsset();
    } else {
      playAudioFromAsset();
    }
  }

  void previousSong() {
    currentSongIndex.value = ((currentSongIndex.value - 1) % playlist.length);
    if (currentSongIndex < 0) {
      currentSongIndex = (playlist.length - 1) as RxInt;
    }
    playAudioFromAsset();
  }

  void pauseOrResumeAudio() {
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
    } else if (audioPlayer.state == PlayerState.paused) {
      audioPlayer.resume();
    } else if (audioPlayer.state == PlayerState.completed) {
      audioPlayer.stop();
    }
  }

  // Lyrics Music
  void updateCurrentLyrics(Duration position) {
    final int currentIndex = currentLyricsIndex.value;
    final List<String> lines =
        playlist[currentSongIndex.value].lyrics.split('\n');
    final int numLines = lines.length;

    if (currentIndex >= numLines) {
      currentLyrics.value = '';
    } else {
      final String currentLine = lines[currentIndex];
      final List<String> parts = currentLine.split(']');
      if (parts.length >= 2) {
        currentLyrics.value = parts[1].trim();
      } else {
        currentLyrics.value = currentLine.trim();
      }
    }
  }

  List<int> extractTimestamps(String lyrics) {
    final List<int> timestamps = [];
    final RegExp regex = RegExp(r'\[(\d+\.\d+)\]');
    final Iterable<RegExpMatch> matches = regex.allMatches(lyrics);
    for (final match in matches) {
      final String timestampStr = match.group(1)!;
      final double timestamp = double.parse(timestampStr);
      timestamps.add((timestamp * 1000).toInt());
    }
    return timestamps;
  }

  List<int> lyricsTimestamps = [];
  final RxList<String> separatedLyrics = RxList<String>([]);

  void initializeLyrics() {
    lyricsTimestamps =
        extractTimestamps(playlist[currentSongIndex.value].lyrics);
  }

  void updateLyrics(Duration position) {
    int index = 0;
    for (int i = 0; i < lyricsTimestamps.length; i++) {
      if (position.inMilliseconds >= lyricsTimestamps[i]) {
        index = i;
      } else {
        break;
      }
    }
    currentLyricsIndex.value = index;
    updateCurrentLyrics(position);
  }
}
