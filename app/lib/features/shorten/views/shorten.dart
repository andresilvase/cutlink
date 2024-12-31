import 'package:cutlink/features/shorten/controller/shorten_controller.dart';
import 'package:cutlink/core/widgets/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Shorten extends StatefulWidget {
  const Shorten({super.key});

  @override
  State<Shorten> createState() => _ShortenState();
}

class _ShortenState extends State<Shorten> {
  final TextEditingController _controller = TextEditingController();
  ShortenController controller = Get.find();
  late String title;

  @override
  initState() {
    title = "Paste your long URL here";
    super.initState();
  }

  Future<void> _shorten() async {
    await controller.shorten(_controller.text);

    if (controller.hasError) {
      Get.snackbar(
        "Error",
        "Invalid URL",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(16),
        colorText: Colors.white,
      );
    } else {
      if (controller.shortenedURL != null) {
        _controller.text = controller.shortenedURL!;
        title = "Here is your shortened URL";
      }
    }
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: controller.shortenedURL!));
    Get.snackbar(
      "Success",
      "URL copied",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(16),
      colorText: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "ShortCut Link",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => Visibility(
          visible: !controller.loading,
          replacement: const Blur(),
          child: ListView(
            children: [
              SizedBox(height: Get.height / 2.5),
              _title(),
              _textField(),
              _shortenButton(),
              _copyButton(),
              _resetButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blueAccent,
          fontSize: 20,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Color? fillColor() {
    return controller.loading || controller.shortenedURL != null
        ? Colors.grey[200]
        : controller.hasError
            ? Colors.red[100]
            : null;
  }

  Widget _textField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            _shorten();
          }
        },
        child: TextFormField(
          autofocus: true,
          controller: _controller,
          readOnly: controller.loading || controller.shortenedURL != null,
          textInputAction: TextInputAction.send,
          decoration: InputDecoration(
            errorText: controller.hasError ? controller.errr : null,
            errorStyle: const TextStyle(color: Colors.red),
            enabledBorder: const OutlineInputBorder(),
            disabledBorder: const OutlineInputBorder(),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            border: const OutlineInputBorder(),
            hintText: "https://your-big-url-here.com.full",
            hintStyle: const TextStyle(color: Colors.grey),
            fillColor: fillColor(),
            filled: true,
          ),
        ),
      ),
    );
  }

  Widget _shortenButton() {
    return Obx(
      () => Visibility(
        visible: controller.shortenedURL == null,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: _shorten,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.blueAccent,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(Get.width, 50),
              ),
            ),
            child: const Text("Shorten", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  Widget _copyButton() {
    return Obx(
      () => Visibility(
        visible: controller.shortenedURL != null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.copy, color: Colors.black),
            onPressed: _copy,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.greenAccent,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(Get.width, 50),
              ),
            ),
            label: const Text("Copy", style: TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  Widget _resetButton() {
    return Obx(
      () => Visibility(
        visible: controller.shortenedURL != null,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          alignment: Alignment.center,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              controller.reset();
              _controller.text = "";
              title = "Paste your long URL here";
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.redAccent,
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              minimumSize: WidgetStateProperty.all(
                Size(Get.width, 50),
              ),
            ),
            label: const Text("Shorten another URL", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
