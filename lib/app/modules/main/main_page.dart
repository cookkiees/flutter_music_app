import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_app/app/modules/main/widgets/main_drawer_widget.dart';
import 'package:music_app/app/modules/music/music_page.dart';
import 'package:music_app/app/modules/playlist/playlist_page.dart';
import 'package:music_app/app/theme/utils/my_colors.dart';
import 'main_controller.dart';
import 'widgets/main_appbar_widget.dart';

class MainPage extends GetView<MainController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.mainScaffoldKey,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: MainAppBarWidget(),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.pageIndex.value,
          children: [
            if (controller.isLoading.value)
              Center(child: CupertinoActivityIndicator(color: Colors.grey[900]))
            else
              const MusicPage(),
            if (controller.isLoading.value)
              Center(child: CupertinoActivityIndicator(color: Colors.grey[900]))
            else
              const PlaylistPage(),
          ],
        ),
      ),
      drawer: const MainDrawerWidget(),
      bottomNavigationBar: Obx(
        () => Container(
          height: 76,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: controller.isPrimaryLight.value,
          alignment: Alignment.topCenter,
          child: GNav(
            gap: 8,
            haptic: true,
            iconSize: 24,
            tabBorderRadius: 8,
            activeColor: controller.isChangeTheme.value
                ? MyColors.primary
                : Colors.grey[100],
            curve: Curves.bounceIn,
            backgroundColor: Colors.transparent,
            color: controller.isChangeTheme.value
                ? Colors.grey[100]
                : Colors.grey[900],
            tabBackgroundColor: MyColors.onPrimary,
            tabActiveBorder: Border.all(
              color: controller.isChangeTheme.value
                  ? Colors.grey[100]!
                  : Colors.grey[900]!,
              width: 0.5,
            ),
            tabBorder: Border.all(
              color: controller.isChangeTheme.value
                  ? Colors.grey[100]!
                  : Colors.grey[900]!,
              width: 0.5,
            ),
            selectedIndex: controller.pageIndex.value,
            onTabChange: controller.onTabSelected,
            duration: const Duration(milliseconds: 900),
            mainAxisAlignment: MainAxisAlignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            tabs: const [
              GButton(
                icon: Icons.graphic_eq,
                text: 'MUSIC',
              ),
              GButton(
                icon: Icons.queue_music,
                text: 'PLAYLIST',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
