import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/screens/edit_profile/edit_profilescreen.dart';
import 'package:ctrl_app/screens/home/home.dart';
import 'package:ctrl_app/screens/wallet_settings/wallet_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/profile_tiles.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.offAll(Home()),
                  child: const Icon(
                    Icons.arrow_back,
                    color: ColorPalette.snow,
                    size: 32,
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, bottom: 16, top: 16),
                    child: Column(
                      children: [
                        Obx(
                          () => CircleAvatar(
                            minRadius: 56,
                            maxRadius: 56,
                            backgroundImage: NetworkImage(
                                authenticationController.profilePicture),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          authenticationController.user.value.userName.isEmpty
                              ? '${authenticationController.firstName.value.capitalizeFirst!} ${authenticationController.lastName.value.capitalizeFirst!}'
                              : authenticationController.user.value.userName,
                          style: const TextStyle(color: ColorPalette.snow),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Active Since ${authenticationController.user.value.dateCreated}',
                          style: const TextStyle(color: ColorPalette.snow),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          authenticationController.missionStatement.value,
                          style: const TextStyle(color: ColorPalette.snow),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => Get.to(EditProfileScreen()),
                  child: const ProfileTiles(
                    header: 'Edit Profile',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const ProfileTiles(header: 'Notifications'),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                    onTap: () => Get.to(WalletSettingsScreen()),
                    child: const ProfileTiles(header: 'Wallet Settings')),
                const SizedBox(
                  height: 16,
                ),
                const ProfileTiles(header: 'Privacy Policy'),
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: ColorPalette.snow.withOpacity(0.17)),
                  onPressed: () {},
                  child: Container(
                      margin: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: const Text(
                        'Log Out',
                        textAlign: TextAlign.center,
                      )),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
