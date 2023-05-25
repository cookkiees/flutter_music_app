import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/app/modules/main/main_controller.dart';
import 'package:music_app/app/modules/playlist/playlist_controller.dart';

import '../music/music_controller.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    PlaylistController controller = Get.put(PlaylistController());
    MusicController music = Get.put(MusicController());

    return GetBuilder<MainController>(
      builder: (main) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    ...List.generate(
                      controller.playlist.length,
                      (i) {
                        var playlist = controller.playlist[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Obx(
                            () => InkWell(
                              onTap: () {
                                music.currentSongIndex.value = i;
                                music.playAudioFromAsset();
                                music.updateCurrentLyrics(music.position.value);
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    top: 6, bottom: 6, left: 6),
                                decoration: BoxDecoration(
                                  color: main.isPrimaryLight.value,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: main.isChangeTheme.value
                                          ? const Color.fromARGB(112, 2, 2, 2)
                                          : Colors.grey[400]!,
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 90,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: Image.asset(
                                              'assets/images/${playlist.image}.jpeg',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              playlist.title,
                                              style: GoogleFonts.urbanist(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                textStyle: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                color: main.isPrimaryDark.value,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              playlist.artist,
                                              style: GoogleFonts.urbanist(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                textStyle: const TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                color: main.isPrimaryDark.value,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    if (music.currentSongIndex.value == i)
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: LottieBuilder.asset(
                                          'assets/lottie/music.json',
                                          width: 60,
                                          height: 30,
                                          delegates: LottieDelegates(
                                            values: [
                                              ValueDelegate.color(
                                                ['lake', 'fill'],
                                                value: Colors.blue,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    else
                                      const SizedBox.shrink()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Obx(
            () {
              var playSong = controller.playlist[controller.currentSong.value];
              return SizedBox(
                height: 65,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          top: 6, left: 16, right: 16, bottom: 6),
                      decoration: BoxDecoration(
                        color: main.isPrimaryLight.value,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    'assets/images/${playSong.image}.jpeg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    playSong.title,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      textStyle: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                      color: main.isPrimaryDark.value,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    playSong.artist,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      textStyle: const TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                      color: main.isPrimaryDark.value,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  music.previousSong();
                                },
                                child: const Icon(
                                  Icons.skip_previous,
                                  size: 24,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (music.isPlaying.value) {
                                    music.pauseOrResumeAudio();
                                  } else {
                                    music.playAudioFromAsset();
                                    music.updateCurrentLyrics(
                                        music.position.value);
                                  }
                                },
                                icon: music.isPlaying.value
                                    ? const Icon(Icons.pause)
                                    : const Icon(Icons.play_arrow),
                              ),
                              InkWell(
                                onTap: () {
                                  music.nextSong();
                                },
                                child: const Icon(
                                  Icons.skip_next,
                                  size: 24,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () {
                        final double progress =
                            music.duration.value.inMilliseconds > 0
                                ? music.position.value.inMilliseconds /
                                    music.duration.value.inMilliseconds
                                : 0.0;
                        return SizedBox(
                          height: 4,
                          child: LinearProgressIndicator(
                            value: progress.isFinite ? progress : 0.0,
                            backgroundColor: main.isChangeTheme.value
                                ? Colors.grey[500]!
                                : Colors.grey[400]!,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                main.isPrimaryDark.value),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
