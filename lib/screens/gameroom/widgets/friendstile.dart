import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class FriendsTile extends StatelessWidget {
  const FriendsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 75,
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
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8, right: 8, left: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              child: Row(
                children:const [
                  SizedBox(
                    width: 16,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/howto/img_avatar.png'),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'Sally',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 16),
                  ),
                  Spacer(),
                  Icon(
                    Icons.add_circle,
                    color: ColorPalette.brightGreen,
                    size: 40,
                  ),
                  SizedBox(
                    width: 16,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
