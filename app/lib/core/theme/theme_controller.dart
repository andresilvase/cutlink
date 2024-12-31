import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void initializeTheme() {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    isDarkMode.value = brightness == Brightness.dark;
  }
}
