import 'package:get/get.dart';

import '../modules/music/music_binding.dart';
import '../modules/music/music_page.dart';
import '../modules/main/main_binding.dart';
import '../modules/main/main_page.dart';
import '../modules/playlist/playlist_binding.dart';
import '../modules/playlist/playlist_page.dart';
import 'app_routes.dart';

abstract class AppPages {
  static const initial = AppRoutes.initial;
  static final pages = [
    GetPage(
      name: AppRoutes.initial,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.music,
      page: () => const MusicPage(),
      binding: MusicBinding(),
    ),
    GetPage(
      name: AppRoutes.playlist,
      page: () => const PlaylistPage(),
      binding: PlaylistBinding(),
    )
  ];
}
