import 'package:ctrl_app/models/participant_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/gameroom_model.dart';

class WorkoutHistory extends StatelessWidget {
  WorkoutHistory({
    Key? key,
    required this.gameRoom,
  }) : super(key: key);
  final bool gameStart = true;
  final HomeController homeController = HomeController.to;
  final GameRoomModel gameRoom;
  final GameRoomController gameRoomController = GameRoomController.to;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  late List<String> history;

  @override
  Widget build(BuildContext context) {
    final ParticipantModel participant = gameRoom.participants!.firstWhere(
        (element) =>
            element.email == authenticationController.user.value.email);
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Center(child: Text('Workout History')),
        actions: const [
          Icon(
            Icons.message,
            color: Colors.transparent,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Game Workout History',
                style: TextStyle(color: ColorPalette.snow, fontSize: 24),
              ),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: participant.gameWeekModel.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: participant
                              .gameWeekModel[index].workoutDays.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Week ${index + 1}: ${DateFormat('dd MMM').format(DateFormat('dd-mm-yyyy').parse(participant.gameWeekModel[index].startDate))} - ${DateFormat('dd MMM').format(DateFormat('dd-mm-yyyy').parse(participant.gameWeekModel[index].endDate))} ',
                                  style: const TextStyle(
                                      color: ColorPalette.snow, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: participant
                                      .gameWeekModel[index].workoutDays.length,
                                  itemBuilder: (context, index2) => Container(
                                      width: double.infinity,
                                      height: 50,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.black,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        DateFormat('dd MMM yyyy').format(
                                            DateFormat('dd-mm-yyyy').parse(
                                                participant
                                                    .gameWeekModel[index]
                                                    .workoutDays[index2]
                                                    .dateWorkedOut)),
                                        style: const TextStyle(
                                            color: ColorPalette.snow,
                                            fontSize: 14),
                                      )),
                                )
                              ],
                            )
                          : Container(),
                    ))
          ],
        )),
      ),
    );
  }
}
