import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/screens/gameroom/widgets/friendstile.dart';
import 'package:ctrl_app/screens/gameroom/widgets/gameroom_searchbar.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorPalette.black, borderRadius: BorderRadius.circular(20)),
      child: Material(
        color: ColorPalette.black,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Invite Friends',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: ColorPalette.snow,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
           const GameRoomSearchBar(),
         const   FriendsTile(),
         const   FriendsTile(),
         const   FriendsTile(),
         const   FriendsTile()
          ],
        ),
      ),
    );
  }
}
