import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:ctrl_app/screens/gameroom/widgets/transparentcard.dart';
import 'package:ctrl_app/screens/workout_history/workout_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  late int weekNumber;
  @override
  Widget build(BuildContext context) {
    weekNumber = gameRoomController.getCurrentWeek(
        gameRoom, authenticationController.user.value);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.8,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 6.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Duration:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '${gameRoom.commitmentPeriod} Weeks',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 12),
                            ),
                            const Spacer(),
                            const Text(
                              'Start date:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(
                                  DateFormat('dd-MM-yyyy')
                                      .parse(gameRoom.startDate!)),
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 12),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Amount In Game:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '\$${gameRoom.potAmount!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Buy in:',
                              style: TextStyle(
                                color: ColorPalette.snow,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '\$${gameRoom.buyInAmount!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: ColorPalette.snow,
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'End Date:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              DateFormat('dd MMM yyyy').format(
                                  DateFormat('dd-MM-yyyy')
                                      .parse(gameRoom.endDate!)),
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 6.2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
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
                              'Week $weekNumber:',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 18),
                            ),
                            Text(
                              '${DateFormat('dd MMM').format(DateFormat('dd-MM-yyyy').parse(gameRoom.startDate!))} - ${DateFormat('dd MMM').format(DateFormat('dd-MM-yyyy').parse(gameRoom.endDate!))}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            const Text(
                              'No of workouts\nthis week:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '${participant.gameWeekModel[weekNumber - 1].workoutDays.length}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Commitment/\nWeek:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '${participant.commitmentAmountPerWeek}/Week',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            const Text(
                              'Commitment\nleft:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '${participant.commitmentAmountPerWeek - participant.gameWeekModel[weekNumber - 1].workoutDays.length}/Week',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                  ),
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 5.8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 24,
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
                              'Week $weekNumber:',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 18),
                            ),
                            Text(
                              '${DateFormat('dd MMM').format(DateFormat('dd-MM-yyyy').parse(gameRoom.startDate!))} - ${DateFormat('dd MMM').format(DateFormat('dd-MM-yyyy').parse(gameRoom.endDate!))}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            const Text(
                              'Current Amount:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '\$${participant.currentAmountHolding!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(WorkoutHistory(gameRoom: gameRoom, ));
                              },
                              style: ButtonStyle(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          ColorPalette.backgroundDarkPurple),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                              child: const Text('Workout History'),
                            )
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Earned Amount:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '\$${participant.currentAmountEarned!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            const Text(
                              'Loss Amount:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '\$${participant.currentAmountLost!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            const Spacer(),
                            const Text(
                              'Loss per\nmissed workout:',
                              style: TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            Text(
                              '\$${participant.lostAmountPerUnit}',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 8,
                        )
                      ],
                    ),
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
