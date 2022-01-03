import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/screens/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameAvatarSection extends StatelessWidget {
  const NameAvatarSection({
    Key? key,
    required this.name,
    required this.photoUrl,
  }) : super(key: key);
final String name;
final String photoUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Hello $name',
                style:const TextStyle(
                  color: ColorPalette.snow,
                  fontSize: 20,
                ),
              ),
            ),
         const   Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Your Dashboard',
                style: TextStyle(
                  color: ColorPalette.snow,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Get.to( ProfilePage()),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16, top: 16),
                child: CircleAvatar(
                  minRadius: 32,
                  maxRadius: 32,
                  backgroundImage:NetworkImage(photoUrl) ,
                 
                ),
              ),
              const Positioned(
                bottom: 4,
                left: 4,
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: ColorPalette.brightGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
