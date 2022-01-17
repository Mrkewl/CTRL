import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';

import 'package:ctrl_app/screens/gameroom/gameroom.dart';
import 'package:ctrl_app/screens/gameroom/widgets/gamebuttons.dart';
import 'package:ctrl_app/screens/search/widgets/game_roomwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipatingGameRooms extends StatelessWidget {
  ParticipatingGameRooms({Key? key}) : super(key: key);
  final GameRoomController gameRoomController = GameRoomController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: Column(
                children: [
                  const Text(
                    'Games Participating',
                    style: TextStyle(
                      color: ColorPalette.snow,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                      gameRoomController.checkInAllGames();
                    },
                    child: const GameButton(
                      header: 'Check In',
                      color: ColorPalette.primaryPurple,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          gameRoomController.participatingGameRoomList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(GameRoom(
                              gameRoom: gameRoomController
                                  .participatingGameRoomList[index],
                            ));
                          },
                          child: GameRoomWidget(
                              id: gameRoomController.gameRoomList[index].id!,
                              name:
                                  gameRoomController.gameRoomList[index].name!,
                              gameCreatorEmail: gameRoomController
                                  .gameRoomList[index].gameCreatorEmail!,
                              commitmentPeriod: gameRoomController
                                  .gameRoomList[index].commitmentPeriod!,
                              participants: gameRoomController
                                  .gameRoomList[index].participants!,
                              potAmount: gameRoomController
                                  .gameRoomList[index].potAmount!,
                              buyInAmount: gameRoomController
                                  .gameRoomList[index].buyInAmount!,
                              started: gameRoomController
                                  .gameRoomList[index].started!,
                              startDate: gameRoomController
                                  .gameRoomList[index].startDate!,
                              endDate: gameRoomController
                                  .gameRoomList[index].endDate!),
                        );
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
