import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/theme/utils/my_colors.dart';

class MainController extends GetxController {
  // Boottom navigation bar
  RxInt pageIndex = 0.obs;

  var isLoading = false.obs;
  void onTabSelected(int index) {
    isLoading.value = true; // Tampilkan Circular Progress Indicator

    // Delay untuk simulasi proses asinkron (misalnya, pengambilan data)
    Future.delayed(const Duration(milliseconds: 200), () {
      // Lakukan perpindahan halaman sesuai dengan indeks yang dipilih
      pageIndex.value = index;
      isLoading.value = false;
    });
  }

  final GlobalKey<ScaffoldState> mainScaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    mainScaffoldKey.currentState?.openDrawer();
  }

  var isPrimaryLight = MyColors.primary.obs;
  var isPrimaryDark = MyColors.onPrimary.obs;

  var isChangeTheme = false.obs;

  void setThemes() {
    isChangeTheme.value = !isChangeTheme.value;
    isPrimaryLight.value =
        isChangeTheme.value ? MyColors.onPrimary : MyColors.primary;
    isPrimaryDark.value =
        isChangeTheme.value ? MyColors.primary : MyColors.onPrimary;
  }
}
