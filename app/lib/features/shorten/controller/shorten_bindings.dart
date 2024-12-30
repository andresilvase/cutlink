import 'package:app/core/model/binding.dart';
import 'package:app/features/shorten/controller/shorten_controller.dart';
import 'package:get/get.dart';

class ShortenBindings extends Binding {
  @override
  void init() {
    Get.lazyPut(() => ShortenController());
  }
}
