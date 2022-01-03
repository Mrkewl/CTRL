import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/screens/create_room/widgets/continuebutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/dropdowntile.dart';

class CreateRoomScreen extends StatelessWidget {
  CreateRoomScreen({Key? key}) : super(key: key);
  final GameRoomController gameRoomController = GameRoomController.to;
  final AuthenticationController authenticationController = AuthenticationController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_left_rounded,
                        size: 45,
                        color: ColorPalette.snow,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Create Room',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                    ),
                    const Spacer(),
                    const SizedBox(
                      width: 32,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(
                  () => DropdownTile(
                      attribute: createRoomAttribute.groupName,
                      title: 'Room Name',
                      createGamevalues: gameRoomController.createGame.value),
                ),
                Obx(
                  () => DropdownTile(
                      attribute: createRoomAttribute.commitmentPeriod,
                      title: 'Commitment Period',
                      createGamevalues: gameRoomController.createGame.value),
                ),
                Obx(
                  () => DropdownTile(
                      attribute: createRoomAttribute.amount,
                      title: 'Amount',
                      createGamevalues: gameRoomController.createGame.value),
                ),
                Obx(
                  () => DropdownTile(
                    attribute: createRoomAttribute.roomLimit,
                    title: 'Room Limit',
                    createGamevalues: gameRoomController.createGame.value,
                  ),
                ),
                Obx(
                  () => DropdownTile(
                    attribute: createRoomAttribute.startDate,
                    title: 'Start Date',
                    createGamevalues: gameRoomController.createGame.value,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: ()async {
                    gameRoomController.createGame.value.gameCreatorEmail = authenticationController.user.value.email;
                      gameRoomController.createGameRoom(context);
                    },
                    child: PurpleMainButtonWidget(text: 'Continue')),
                const SizedBox(
                  height: 56,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
