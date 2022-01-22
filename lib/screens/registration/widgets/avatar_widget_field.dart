import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AvatarFieldWidget extends StatelessWidget {
  AvatarFieldWidget({
    Key? key,
  }) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          height: 70,
          decoration: BoxDecoration(
              color: ColorPalette.black,
              borderRadius: BorderRadius.circular(360)),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Tap On The Ninja & \n Upload Your Avatar ',
                style: TextStyle(color: ColorPalette.snow, fontSize: 18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                  width: 70,
                  height: 70,
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
                  ),
                  child: Obx(
                    () => !authenticationController
                            .loadingIndicatorForProfileUpload.value
                        ? authenticationController.avatarImage.value.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/logo/ninja.png',
                                  scale: 3,
                                ),
                              )
                            : Image.network(
                                authenticationController.avatarImage.value,
                                fit: BoxFit.cover,
                              )
                        : const CircularProgressIndicator(),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
