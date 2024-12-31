import 'package:cutlink/core/theme/theme_controller.dart';
import 'package:cutlink/core/model/binding.dart';
import 'package:get/get.dart';

class ThemeBindings extends Binding {
  @override
  void init() {
    Get.lazyPut(() => ThemeController());
  }
}
