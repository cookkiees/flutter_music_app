import 'package:get/get.dart';

import '../music/music_controller.dart';
import 'playlist_controller.dart';

class PlaylistBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MusicController>(MusicController());
    Get.lazyPut<PlaylistController>(() => PlaylistController());
  }
}
