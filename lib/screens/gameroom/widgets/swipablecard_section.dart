import 'package:flutter/material.dart';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:ctrl_app/screens/gameroom/widgets/transparentcard.dart';

class SwipableCardSection extends StatelessWidget {
  SwipableCardSection({
    Key? key,
    required this.gameRoom,
    required this.participant,
    required this.totalWorkoutLeft,
  }) : super(key: key);

  final HomeController homeController = HomeController.to;
  final GameRoomController gameRoomController = GameRoomController.to;
  final GameRoomModel gameRoom;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  final ParticipantModel participant;
  final int totalWorkoutLeft;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.6,
      child: PageView(
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        onPageChanged: (pageNumber) {
          homeController.gameRoomCard.value = pageNumber;
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransparentCard(
              listofWidgets: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Duration:\n${gameRoom.commitmentPeriod} Weeks',
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      'Total Amount\n In Game: \n\$${gameRoom.potAmount!.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 18),
                    ),
                  ],
                ),
                Text(
                  'Start date: ${gameRoom.startDate}\nEnd Date: ${gameRoom.endDate}',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 18),
                ),
                const Spacer(),
                Text(
                  'Buy in:\n\$${gameRoom.buyInAmount!.toStringAsFixed(2)}',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransparentCard(
              listofWidgets: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            authenticationController.profilePicture),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Commitment:  ${participant.commitmentAmountPerWeek}/ Week',
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Missed: ${participant.totalMissedWorkout}',
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Duration Left: \n' +
                                gameRoomController.getWeeksLeft(gameRoom),
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Total Workout Left This Week: $totalWorkoutLeft',
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
