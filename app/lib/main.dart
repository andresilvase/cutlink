import 'package:cutlink/core/init_dependencies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cutlink/core/routes/router.dart';
import 'package:cutlink/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      onGenerateRoute: AppRouter.onGenerateroute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.root,
    );
  }
}
