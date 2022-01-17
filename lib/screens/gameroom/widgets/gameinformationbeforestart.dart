import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:flutter/material.dart';

import 'gamebuttons.dart';
import 'invitefriends.dart';

class GameInformationBeforeStart extends StatelessWidget {
  GameInformationBeforeStart({
    Key? key,
    required this.commitmentWeeks,
    required this.buyInAmount,
    required this.amountInPot,
    required this.roomLimit,
    required this.startDate,
    required this.endDate,
    required this.documentId,
    required this.gameRoom,
  }) : super(key: key);
  final GameRoomController gameController = GameRoomController.to;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  final int commitmentWeeks;
  final double buyInAmount;
  final double amountInPot;
  final int roomLimit;
  final String startDate;
  final String endDate;
  final String documentId;
  final GameRoomModel gameRoom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 16, top: 16, right: 4, bottom: 16),
      margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.2),
            offset: const Offset(0, 4),
            spreadRadius: 3,
            blurRadius: 5,
          )
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$commitmentWeeks Weeks',
                style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
              ),
              Text(
                '\$$buyInAmount buy in ',
                style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
              ),
              Text(
                'Total Amount \$$amountInPot',
                style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
              ),
              Text(
                '$roomLimit Participant Limit',
                style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
              ),
              Text(
                '$startDate - $endDate',
                style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // gameController.createGameWeekModels(gameRoom);
                    // print(documentId);
                    // gameController.retriveAndAddIdToCollection();
                    gameController.participateInGame(
                        context: context,
                        gameRoom: gameRoom,
                        user: authenticationController.user.value);
                  },
                  child: const GameButton(
                    header: 'Join Game',
                    color: ColorPalette.brightGreen,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () => {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return const InviteFriends();
                      },
                    )
                  },
                  child: const GameButton(
                    header: 'Invite',
                    color: ColorPalette.brightGreen,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
