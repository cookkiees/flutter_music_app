import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/modules/music/music_controller.dart';

import '../../main/main_controller.dart';

class CardMusicWidget extends GetView<MusicController> {
  const CardMusicWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (main) {
        return Obx(
          () => Center(
            child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                controller.handleHorizontalDragUpdate(details);
              },
              child: Container(
                height: 420,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 16),
                margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: main.isPrimaryLight.value,
                  borderRadius: BorderRadius.circular(8),
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
                child: Obx(
                  () => Column(
                    children: [
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Opacity(
                            opacity: 0.8,
                            child: Image.asset(
                              'assets/images/${controller.playlist[controller.currentSongIndex.value].image}.jpeg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 18,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              controller
                                  .playlist[controller.currentSongIndex.value]
                                  .title,
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                color: main.isPrimaryDark.value,
                              ),
                            ),
                            Text(
                              controller
                                  .playlist[controller.currentSongIndex.value]
                                  .artist,
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                textStyle: const TextStyle(
                                    overflow: TextOverflow.ellipsis),
                                color: main.isPrimaryDark.value,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
