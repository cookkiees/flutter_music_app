import 'package:get/get.dart';
import 'music_controller.dart';

class MusicBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<MusicController>(MusicController());
  }
}
