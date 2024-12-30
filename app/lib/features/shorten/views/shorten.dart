import 'package:app/features/shorten/controller/shorten_controller.dart';
import 'package:app/core/widgets/blur.dart';
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
      title = "Here is your shortened URL";
      _controller.text = controller.shortenedURL!;
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
          "CutLink",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height / 3),
              _title(controller.shortenedURL != null),
              _textField(),
              _shortenButton(),
              _copyButton(controller.shortenedURL != null),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(bool shortened) {
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

  Widget _textField() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        readOnly: controller.loading || controller.shortenedURL != null,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(),
          border: const OutlineInputBorder(),
          hintText: "https://your-big-url-here.com.full",
          hintStyle: const TextStyle(color: Colors.grey),
          fillColor: controller.loading || controller.shortenedURL != null ? Colors.grey[200] : Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget _shortenButton() {
    return Obx(
      () => Visibility(
        visible: controller.shortenedURL == null,
        child: Center(
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
                Size(Get.width / 1.01, 50),
              ),
            ),
            child: const Text("Shorten", style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    );
  }

  Widget _copyButton(bool show) {
    return Obx(
      () => Visibility(
        visible: controller.shortenedURL != null,
        child: Visibility(
          visible: show,
          child: Center(
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
                  Size(Get.width / 1.01, 50),
                ),
              ),
              label: const Text("Copy", style: TextStyle(color: Colors.black)),
            ),
          ),
        ),
      ),
    );
  }
}
