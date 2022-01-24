import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/all_animation_controller.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/editmissiontextboxwidget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  final TextEditingController missionStatement = TextEditingController();
  final AllAnimationController allAnimationController = AllAnimationController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(color: ColorPalette.snow, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.off(ProfilePage());
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      authenticationController.missionStatement.value =
                          missionStatement.text;

                      //this is to make sure the missionstatement get saved 1st
                      await Future.delayed(const Duration(seconds: 1));
                      authenticationController
                          .changeMissionStatement()
                          .then((value) => Navigator.pop(context));
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          allAnimationController
                              .loadingIndicatorForProfileUpload.value = true;
                          await authenticationController
                              .uploadImageToFirebase();
                          allAnimationController
                              .loadingIndicatorForProfileUpload.value = false;
                        },
                        child: Obx(() => CircleAvatar(
                              backgroundColor: ColorPalette.black,
                              minRadius: 40,
                              maxRadius: 40,
                              backgroundImage: !allAnimationController
                                      .loadingIndicatorForProfileUpload.value
                                  ? NetworkImage(
                                      authenticationController.profilePicture)
                                  : null,
                              child: allAnimationController
                                      .loadingIndicatorForProfileUpload.value
                                  ? const CircularProgressIndicator()
                                  : null,
                            )),
                      ),
                      const Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: ColorPalette.snow,
                          )),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authenticationController.userName.value,
                        style: const TextStyle(
                            color: ColorPalette.snow, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        authenticationController.email.value,
                        style: const TextStyle(
                            color: ColorPalette.snow, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            EditMissionTextBox(
              missionStatement: missionStatement,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  authenticationController.email.value,
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
