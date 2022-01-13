import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/screens/gameroom/widgets/participant_card.dart';
import 'package:flutter/material.dart';

import 'widgets/cardsection_dots.dart';
import 'widgets/gameinformationbeforestart.dart';
import 'widgets/swipablecard_section.dart';

class GameRoom extends StatelessWidget {
  GameRoom({
    Key? key,
    required this.gameRoom,
  }) : super(key: key);
  final bool gameStart = true;
  final HomeController homeController = HomeController.to;
  final GameRoomModel gameRoom;
  final GameRoomController gameRoomController = GameRoomController.to;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Center(child: Text('Game Room')),
        actions: const [
          Icon(
            Icons.message,
            color: ColorPalette.brightGreen,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gameRoom.name!,
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 24),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          'Participants',
                          style:
                              TextStyle(color: ColorPalette.snow, fontSize: 16),
                        ),
                        Text(
                          gameRoom.participants!.length.toString(),
                          style: const TextStyle(
                              color: ColorPalette.snow, fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: ()async {
                  // gameRoomController.participateInGame(
                      // gameRoom: gameRoom,
                      // user: authenticationController.user.value,
                      // context: context);
                  // gameRoomController.workoutCheckin(
                  //     gameRoom, authenticationController.user.value);
                  //  gameRoomController.checkMissedWorkout();
                  // gameRoomController.individuallossAmountPerWeek();
                  // print(await gameRoomController.getTotalAmountLossAtEndWeek(gameRoom));
                  // print(await gameRoomController.totalAmountOfUnits(gameRoom));
                // print(gameRoomController.getListEachParticipantAmountLossAtEndWeek());
                gameRoomController.controllerSetUp(authenticationController.user.value);
                  // gameRoomController.updatePotAmount(gameRoom);
                //  gameRoomController.updateDocumentInStorage();
                },
                icon: const Icon(Icons.ac_unit),
              ),
              if (gameRoom.started != true)
                GameInformationBeforeStart(
                  gameRoom: gameRoom,
                  documentId: gameRoom.documentId!,
                  amountInPot: gameRoom.potAmount!,
                  buyInAmount: gameRoom.buyInAmount!,
                  commitmentWeeks: gameRoom.commitmentPeriod!,
                  endDate: gameRoom.endDate!,
                  roomLimit: gameRoom.roomLimit!,
                  startDate: gameRoom.startDate!,
                ),
              if (gameRoom.started == true) SwipableCardSection(),
              if (gameRoom.started == true)
                CardSectionDots(
                  dotNumber: homeController.gameRoomCard.value,
                ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Participants',
                          style:
                              TextStyle(color: ColorPalette.snow, fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          'Invite Only',
                          style:
                              TextStyle(color: ColorPalette.snow, fontSize: 18),
                        ),
                      ],
                    ),
                    ListView.builder(
                        itemCount: gameRoom.participants!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ParticipantCard(
                            avatarImage: gameRoom.participants![index].photoUrl,
                            name: gameRoom.participants![index].userName,
                            missedWorkout: gameRoom
                                .participants![index].totalMissedWorkout
                                .toString(),
                            totalAmount: 0.toString(),
                            earned: gameRoom
                                .participants![index].currentAmountEarned
                                .toString(),
                            commitment: gameRoom
                                .participants![index].commitmentAmountPerWeek
                                .toString()))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
