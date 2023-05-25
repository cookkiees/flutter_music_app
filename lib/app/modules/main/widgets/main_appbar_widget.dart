import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/theme/utils/my_colors.dart';

import '../main_controller.dart';

class MainAppBarWidget extends GetView<MainController> {
  const MainAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => controller.openDrawer(),
          icon: const Icon(Icons.subject_outlined, size: 32),
        ),
        title: Text(
          (controller.pageIndex.value == 0) ? "MUSIC" : "PLAYLIST",
          style: const TextStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => controller.setThemes(),
              child: Container(
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.isChangeTheme.value
                      ? MyColors.onPrimary
                      : MyColors.primary,
                  border: Border.all(
                    width: 0.5,
                    color: controller.isChangeTheme.value
                        ? MyColors.primary
                        : MyColors.onPrimary,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  controller.isChangeTheme.value ? 'DARK' : 'LIGHT',
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
