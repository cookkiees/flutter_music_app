import 'package:get/get.dart';
import 'package:music_app/app/modules/music/music_controller.dart';

import '../../data/model/music_model.dart';

class PlaylistController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final MusicController musicController = Get.find<MusicController>();

  RxBool isPressed = false.obs;

  void togglePressed() {
    isPressed.value = !isPressed.value;
  }

  final List<Music> playlist = [];
  var currentSong = 0.obs;

  // ignore: recursive_getters

  void movePlaylistItemsFromSource() {
    List<Music> newPlaylist = musicController.playlist;
    playlist.addAll(newPlaylist);
    currentSong = musicController.currentSongIndex;
  }

  @override
  void onInit() {
    movePlaylistItemsFromSource();
    super.onInit();
  }
}
