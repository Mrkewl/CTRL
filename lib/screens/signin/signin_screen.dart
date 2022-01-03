import 'dart:io';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/common/widgets/landingpage_button_widget.dart';
import 'package:ctrl_app/common/widgets/registrationtextfield_widget.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/screens/home/home.dart';
import 'package:ctrl_app/screens/registration/widgets/applechip_widget.dart';
import 'package:ctrl_app/screens/registration/widgets/googlechip_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/signin.png',
                  scale: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                    child: Text(
                  'Sign In',
                  style: TextStyle(color: ColorPalette.snow, fontSize: 28),
                )),
                const SizedBox(
                  height: 8,
                ),
                const Center(
                    child: Text(
                  'Make the best choice for your fitness and \n health',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorPalette.greyRegisterDescription,
                      fontSize: 15),
                )),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (Platform.isIOS) ...[
                      const AppleChip(),
                      GoogleChip()
                    ] else
                      GoogleChip(),
                  ],
                ),
                RegistrationSignInTextField(
                  gender: false,
                  birthday: false,
                  fields: authenticationController.email,
                  header: 'Email',
                ),
                RegistrationSignInTextField(
                  birthday: false,
                  gender: false,
                  fields: authenticationController.password,
                  header: 'Password',
                ),
                GestureDetector(
                    onTap: () async {
                  
                      authenticationController.loadingIndicator.value = true;

                      if (await authenticationController
                          .signInWithEmail(context)) {
                        authenticationController.loadingIndicator.value = false;
                        Get.to(Home());
                      }
                    },
                    child: PurpleMainButtonWidget(
                      text: 'Sign In',
                    )),
                const Center(
                    child: Text(
                  'Don’t have an Account? Signup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorPalette.greyRegisterDescription,
                      fontSize: 15),
                )),
                const Center(
                    child: Text(
                  'Forget Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorPalette.greyRegisterDescription,
                      fontSize: 15),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
