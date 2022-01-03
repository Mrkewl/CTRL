

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/screens/landing_page/widgets/introductionglass_description_widget.dart';
import 'package:ctrl_app/screens/registration/registration_screen.dart';
import 'package:ctrl_app/screens/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/landingpage_button_widget.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backgroundDarkPurple,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 6.5,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Image.asset('assets/images/yoga.png')),
              const SizedBox(
                height: 24,
              ),
              const IntroductionGlassDescription(
                  text: 'Get Rewarded With Health'),
              const SizedBox(
                height: 16,
              ),
              const IntroductionGlassDescription(
                  text: 'Get Rewarded With Crypto'),
              const Spacer(),
            
              GestureDetector(
                onTap: ()=>Get.to( SignIn()),
                child:   PurpleMainButtonWidget(text:  'Login',)),
              GestureDetector(
                
                onTap: ()=>Get.to(  Registration()),
                child:  PurpleMainButtonWidget(text:  'Register',)),
     
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ));
  }
}



