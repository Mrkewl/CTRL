import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/screens/registration/register_information_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/flavor_config.dart';
import 'screens/home/home.dart';
import 'screens/landing_page/landingpage_screen.dart';

Future<void> mainCommon(FlavorConfig config) async {
  Get.put(HomeController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthenticationController());
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  Get.put(GameRoomController());
  final GameRoomController gameRoomController = GameRoomController.to;
  await authenticationController.getUserInfo();
  if (authenticationController.user.value.email.isNotEmpty) {
    await gameRoomController
        .controllerSetUp(authenticationController.user.value);
  }
  await authenticationController
      .setUpAuthController(gameRoomController.gameRoomList);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: authenticationController.auth.currentUser != null
          ? authenticationController.registrationInformation.value
              ? Home()
              : RegisterInformation()
          : LandingPage(),
    );
  }
}
