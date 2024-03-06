import 'package:tawjih/controller/auth_controller.dart';
import 'package:tawjih/core/services.dart';
import 'package:tawjih/routes.dart';
import 'package:tawjih/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:tawjih/core/services.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

bool islogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initialServices();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
        title: 'Collège Maroc',
        initialRoute: "/",
        home: ControlView(),
        getPages: routes,
        builder: EasyLoading.init(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'roboto',
          textTheme: TextTheme(
            headlineSmall: TextStyle(fontFamily: 'almarai'),
            headlineMedium: TextStyle(fontFamily: 'almarai'),
            headlineLarge: TextStyle(fontFamily: 'almarai'),
            labelSmall: TextStyle(fontFamily: 'almarai'),
            labelMedium: TextStyle(fontFamily: 'almarai'),
            titleMedium: TextStyle(fontFamily: 'almarai'),
            titleSmall: TextStyle(fontFamily: 'almarai'),
          ),
        ));
  }
}
