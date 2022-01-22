import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/common/widgets/landingpage_button_widget.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/screens/registration/register_information_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/registrationtextfield_widget.dart';
import 'widgets/applechip_widget.dart';
import 'widgets/googlechip_widget.dart';

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);
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
                 Align(
                  alignment: Alignment.topLeft,
                  child:  GestureDetector(
                    onTap: (){Navigator.pop(context);},
                    child: const Icon(Icons.arrow_back_rounded, size: 40,
                    color: ColorPalette.snow,),
                  )),
                const SizedBox(
                  height: 16,
                ),
                const Center(
                    child: Text(
                  'Register',
                  style: TextStyle(color: ColorPalette.snow, fontSize: 28),
                )),
                const SizedBox(
                  height: 16,
                ),
                const Center(
                    child: Text(
                  'Make the best choice for your fitness and \n health',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorPalette.greyRegisterDescription,
                      fontSize: 15),
                )),
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
                const SizedBox(
                  height: 16,
                ),
                RegistrationSignInTextField(
                  gender: false,
                  birthday: false,
                  fields: authenticationController.email,
                  header: 'Email',
                ),
                RegistrationSignInTextField(
                  gender: false,
                  birthday: false,
                  fields: authenticationController.password,
                  header: 'Password',
                ),
                RegistrationSignInTextField(
                  gender: false,
                  birthday: false,
                  header: 'Confirm Password',
                  fields: authenticationController.confirmPassword,
                ),
                const SizedBox(
                  height: 80,
                ),
                GestureDetector(
                    onTap: () async {
                      try {
                      authenticationController.loadingIndicator.value = true;
                        if (await authenticationController
                            .validationCheckRegistration(context)) {
                           authenticationController.loadingIndicator.value = false;
                          Get.to(RegisterInformation());
                        }
                         authenticationController.loadingIndicator.value = false;
                      } catch (e) {
                        log(e.toString());
                      }
                    },
                    child:  PurpleMainButtonWidget(text: 'Register'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
