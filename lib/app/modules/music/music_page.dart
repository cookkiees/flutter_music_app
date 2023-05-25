import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/modules/music/music_controller.dart';
import '../../theme/utils/my_strings.dart';
import '../main/main_controller.dart';
import 'widgets/card_music_widget.dart';

class MusicPage extends GetView<MusicController> {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (main) {
        MusicController controller = Get.put(MusicController());
        return Obx(
          () => Scaffold(
            backgroundColor: main.isPrimaryLight.value,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CardMusicWidget(),
                    const SizedBox(height: 24),
                    Obx(
                      () => Text(
                        controller.currentLyrics.value,
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          textStyle:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                          color: main.isPrimaryDark.value,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 16, left: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Flexible(
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  formatTime(controller.position.value),
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    color: main.isPrimaryDark.value,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Flexible(
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  formatTime(controller.duration.value -
                                      controller.position.value),
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                    color: main.isPrimaryDark.value,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Obx(
                          () {
                            final double progress =
                                controller.duration.value.inMilliseconds > 0
                                    ? controller.position.value.inMilliseconds /
                                        controller.duration.value.inMilliseconds
                                    : 0.0;
                            return LinearProgressIndicator(
                              value: progress.isFinite ? progress : 0.0,
                              minHeight: 10,
                              backgroundColor: main.isChangeTheme.value
                                  ? Colors.grey[500]!
                                  : Colors.grey[400]!,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  main.isPrimaryDark.value),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.previousSong();
                          },
                          child: const Icon(
                            Icons.skip_previous,
                            size: 42,
                          ),
                        ),
                        const SizedBox(width: 32),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              if (controller.isPlaying.value) {
                                controller.pauseOrResumeAudio();
                              } else {
                                controller.playAudioFromAsset();
                                controller.updateCurrentLyrics(
                                    controller.position.value);
                              }
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: main.isPrimaryLight.value,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: main.isChangeTheme.value
                                        ? const Color.fromARGB(112, 2, 2, 2)
                                        : Colors.grey[400]!,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: controller.isPlaying.value
                                  ? const Icon(Icons.pause, size: 48)
                                  : const Icon(Icons.play_arrow, size: 48),
                            ),
                          ),
                        ),
                        const SizedBox(width: 32),
                        InkWell(
                          onTap: () {
                            controller.nextSong();
                          },
                          child: const Icon(
                            Icons.skip_next,
                            size: 42,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
