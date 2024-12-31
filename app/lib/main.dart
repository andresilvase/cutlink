import 'package:cutlink/core/theme/theme_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cutlink/core/init_dependencies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cutlink/core/routes/router.dart';
import 'package:cutlink/core/routes/routes.dart';
import 'package:cutlink/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void countAccess() {
  if (!kDebugMode) {
    FirebaseFirestore.instance
        .doc("${kDebugMode ? "debug" : "prod"}/access")
        .set({"count": FieldValue.increment(1)}, SetOptions(merge: true));
  }
}

Future<void> main() async {
  String envFile = kDebugMode ? 'env/.env.dev' : 'env/.env.prod';
  await dotenv.load(fileName: envFile);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  countAccess();

  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }

  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    themeController.initializeTheme();

    return Obx(() {
      return GetMaterialApp(
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        onGenerateRoute: AppRouter.onGenerateroute,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        initialRoute: Routes.root,
        theme: ThemeData.light(),
      );
    });
  }
}
