import 'package:app/core/model/full_url.dart';
import 'package:app/features/shorten/controller/shorten_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Shorten extends StatefulWidget {
  const Shorten({super.key});

  @override
  State<Shorten> createState() => _ShortenState();
}

class _ShortenState extends State<Shorten> {
  ShortenController controller = Get.find();

  @override
  void initState() {
    controller.shorten(
      FullUrl(
        url: "https://translate.google.com/?hl=pt-BR&tab=wT&sl=en&tl=pt&text=shorten&op=translate",
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
