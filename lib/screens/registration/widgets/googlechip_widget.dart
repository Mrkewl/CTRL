import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register_information_page.dart';

class GoogleChip extends StatelessWidget {
  GoogleChip({
    Key? key,
 
  }) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
     final   googleSignupResults googleSignUpResults =  await authenticationController.signInSignUpWithGoogle(context);
     
          if (googleSignUpResults ==
              googleSignupResults.signIn) {
            Get.to(Home());
          } else if (googleSignUpResults ==
              googleSignupResults.register) {
            Get.to(RegisterInformation());
          }
        
      },
      child: Stack(alignment: Alignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 6),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.8,
            height: MediaQuery.of(context).size.height / 18,
            decoration: const BoxDecoration(
              color: ColorPalette.snow,
              borderRadius: BorderRadius.all(Radius.circular(360)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.8,
                height: MediaQuery.of(context).size.height / 18,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(360)),
                  // border: Border.all(
                  //   width: 1.5,
                  //   color: Colors.white.withOpacity(0.2),
                  // ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/logo/google.png',
                      scale: 6,
                    ),
                    const Text(
                      'Google',
                      style: TextStyle(
                          color: ColorPalette.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
