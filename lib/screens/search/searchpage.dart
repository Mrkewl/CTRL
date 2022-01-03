import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/screens/create_room/create_room_screen.dart';
import 'package:ctrl_app/screens/gameroom/gameroom.dart';
import 'package:ctrl_app/screens/search/widgets/game_roomwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/search_barwidget.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
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
                  Row(
                    children: [
                      const SearchBar(),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(CreateRoomScreen());
                        },
                        child: const Icon(
                          Icons.add_circle,
                          size: 45,
                          color: ColorPalette.brightGreen,
                        ),
                      )
                    ],
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       Get.to( GameRoom());
                  //     },
                  //     child: const GameRoomWidget(
                  //         )),
                  //  GameRoomWidget(),
                  Obx(() => ListView.builder(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: gameRoomController.gameRoomList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Get.to(
                              GameRoom(
                                gameRoom: gameRoomController.gameRoomList[index],
                              )
                            );
                          },
                          child: GameRoomWidget(
                              id: gameRoomController.gameRoomList[index].id!,
                              name: gameRoomController.gameRoomList[index].name!,
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
                              started:
                                  gameRoomController.gameRoomList[index].started!,
                              startDate: gameRoomController
                                  .gameRoomList[index].startDate!,
                              endDate: gameRoomController
                                  .gameRoomList[index].endDate!),
                        );
                      })),
                  // const GameRoomWidget(),
                  // const GameRoomWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
