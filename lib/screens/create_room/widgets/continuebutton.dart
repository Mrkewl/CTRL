
import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:flutter/material.dart';

class PurpleMainButtonWidget extends StatelessWidget {
 PurpleMainButtonWidget({
    Key? key,
    required this.text,

  }) : super(key: key);
final String text;
final AuthenticationController authenticationController = AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: MediaQuery.of(context).size.height / 13,
          decoration: BoxDecoration(
            color: ColorPalette.primaryPurple,
            boxShadow: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.2),
                offset: const Offset(0, 4),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(360)),
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
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 13,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    const BorderRadius.all(Radius.circular(360)),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child:  Center(
                  child:
                  // Obx(()=> authenticationController.loadingIndicator.value == false?
                   Text(
               text,
                style:
                    const TextStyle(color: ColorPalette.snow, fontSize: 20),
              ) 
              // : const CircularProgressIndicator(),)
              ,),
            ),
          ),
        ),
      ),
    ]);
  }
}
