import 'package:get/get_connect/http/src/utils/utils.dart';
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
  await dotenv.load(fileName: ".env");
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
    return const GetMaterialApp(
      onGenerateRoute: AppRouter.onGenerateroute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.root,
    );
  }
}
