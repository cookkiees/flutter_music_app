import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/app/modules/music/music_controller.dart';

import '../main_controller.dart';

class MainDrawerWidget extends GetView<MainController> {
  const MainDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MusicController music = Get.put(MusicController());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 300,
            child: DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.1,
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/${music.playlist[music.currentSongIndex.value].image}.jpeg',
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Icon(
                  Icons.graphic_eq,
                  size: 150,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.music_note,
              color: controller.isPrimaryDark.value,
            ),
            title: Text(
              "Get songs",
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                color: controller.isPrimaryDark.value,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.error,
              color: controller.isPrimaryDark.value,
            ),
            title: Text(
              'About me',
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                color: controller.isPrimaryDark.value,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.logout_outlined,
              color: controller.isPrimaryDark.value,
            ),
            title: Text(
              'Logout',
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
                color: controller.isPrimaryDark.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
