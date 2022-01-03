import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/models/creategame_model.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/models/gameweek_model.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:ctrl_app/models/user_model.dart';
import 'package:ctrl_app/models/workoutday_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GameRoomController extends GetxController {
  static GameRoomController get to => Get.find();
  final RxBool gameStart = false.obs;
  final RxList<GameRoomModel> gameRoomList = <GameRoomModel>[].obs;
  final Rx<CreateGame> createGame = CreateGame().obs;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  final RxString currentGameRoomId = ''.obs;

  CollectionReference gameRooms =
      FirebaseFirestore.instance.collection('gamerooms');

  Future<void> getGameRoom() async {
    try {
      await gameRooms.get().then((QuerySnapshot querySnapshot) => {
            for (QueryDocumentSnapshot queryDocumentSnapshot
                in querySnapshot.docs)
              {
                gameRoomList.add(GameRoomModel.fromMap(
                    queryDocumentSnapshot.data()! as Map<String, dynamic>)),
              }
          });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> triggerStartGame() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      if (weekCheck(
          startDate: gameRoom.startDate!, endDate: gameRoom.endDate!)) {
        if (gameRoom.started == false) {
          gameRoom.started = true;
          gameRooms.doc(gameRoom.documentId).update({'started': true});
        }
      }
    }
  }

  Future<void> checkMissedWorkout() async {
    print('hello');
    for (final GameRoomModel gameRoom in gameRoomList) {
      // print(gameRoom);

      for (final ParticipantModel participant in gameRoom.participants!) {
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          // print(gameWeek);
          // print(DateFormat('dd-MM-yyyy')
          //     .parse(gameWeek.endDate)
          //     .isBefore(DateTime(2022, 1, 7)));

          if (DateFormat('dd-MM-yyyy')
                  .parse(gameWeek.endDate)
                  .isBefore(DateTime(2022, 1, 7)) ||
              DateFormat('dd-MM-yyyy')
                  .parse(gameWeek.endDate)
                  .isAtSameMomentAs(DateTime(2022, 1, 7))) {
            if (gameWeek.workoutDays.length <
                participant.commitmentAmountPerWeek) {
              gameWeek.missedWorkoutThisWeek =
                  participant.commitmentAmountPerWeek -
                      gameWeek.workoutDays.length;
              print(gameWeek.missedWorkoutThisWeek);
            } else if (gameWeek.workoutDays.length >=
                participant.commitmentAmountPerWeek) {
              gameWeek.missedWorkoutThisWeek == 0;
              print(gameWeek.missedWorkoutThisWeek);
            } else {
              print('hello');
            }
          }
        }
      }
    }
  }

  Future<void> createGameRoom(BuildContext context) async {
    if (await validateCreateRoom(context) == false) {
      return;
    } else {
      try {
        final GameRoomModel createNewGameRoom = GameRoomModel(
          buyInAmount: createGame.value.amount!.toDouble(),
          endDate: DateFormat('dd-MM-yyyy')
              .format(createGame.value.endPeriod)
              .toString(),
          id: 1.toString(),
          name: createGame.value.roomName,
          participants: [
            // ParticipantModel(
            //   gameWeekModel: [],
            //   email: authenticationController.email.value,
            //   commitmentAmountInChallenge: 0,
            //   commitmentAmountPerWeek: 0,
            //   currentAmountEarned: 0,
            //   currentAmountHolding: 0,
            //   currentAmountLost: 0,
            //   photoUrl: authenticationController.profilePicture,
            //   userName: authenticationController.user.value.userName,
            // )
          ],
          potAmount: 0,
          startDate: DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
          started: false,
          commitmentPeriod: createGame.value.commitmentPeriod,
          gameCreatorEmail: createGame.value.gameCreatorEmail,
          roomLimit: createGame.value.roomLimit,
        );

        await gameRooms.doc().set(createNewGameRoom.toMap());
        await retriveAndAddIdToCollection();
        gameRoomList.clear();
        await getGameRoom();
        createGame.value = CreateGame();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<void> retriveAndAddIdToCollection() async {
    await gameRooms.get().then((QuerySnapshot querySnapshot) async {
      for (final QueryDocumentSnapshot queryDocumentSnapshot
          in querySnapshot.docs) {
        await gameRooms.doc(queryDocumentSnapshot.id).set(
            {'documentId': queryDocumentSnapshot.id}, SetOptions(merge: true));
      }
    });
  }

  Future<bool> validateCreateRoom(BuildContext context) async {
    if (createGame.value.amount == null ||
        createGame.value.roomName == null ||
        createGame.value.commitmentPeriod == null ||
        createGame.value.roomLimit == null ||
        createGame.value.startPeriod == null ||
        createGame.value.amount.isBlank! ||
        createGame.value.roomName!.isEmpty ||
        createGame.value.commitmentPeriod.isBlank! ||
        createGame.value.roomLimit.isBlank! ||
        createGame.value.startPeriod.isBlank!) {
      showDialog(
          context: context,
          builder: (context) => const SimpleDialog(
                children: [
                  Text('Please Fill Up All The Fields Before Creating Game')
                ],
              ));
      return false;
    } else {
      return true;
    }
  }

  List<GameWeekModel> createGameWeekModels(GameRoomModel gameRoom) {
    final List<GameWeekModel> gameWeeksStructureList = [];
    for (int i = 0; i < gameRoom.commitmentPeriod!; i++) {
      final DateTime startDate = DateFormat('dd-MM-yyyy')
          .parse(gameRoom.startDate!)
          .add(Duration(days: i * 7));

      final DateTime endDate = DateFormat('dd-MM-yyyy')
          .parse(gameRoom.startDate!)
          .add(Duration(days: (i + 1) * 7));

      gameWeeksStructureList.add(GameWeekModel(
        workoutDays: [],
        completedWorkoutThisWeek: 0,
        earnedThisweek: 0,
        endDate: DateFormat('dd-MM-yyyy').format(endDate),
        lostThisWeek: 0,
        missedWorkoutThisWeek: 0,
        startDate: DateFormat('dd-MM-yyyy').format(startDate),
      ));
    }

    return gameWeeksStructureList;
  }

  Future<void> workoutCheckin(GameRoomModel gameRoom, UserModel user) async {
    ///*This is to check which participant
    final int participantIndex = gameRoom.participants!
        .indexWhere((element) => element.email == user.email);
    print(participantIndex);

    ///*This is to check which week
    for (final GameWeekModel gameWeek
        in gameRoom.participants![participantIndex].gameWeekModel) {
      if (weekCheck(startDate: gameWeek.startDate, endDate: gameWeek.endDate)) {
        ///*This is to check if user has worked out today
        if (workoutCheckInToday(gameWeek.workoutDays)) {
          print('You have already worked out today');
        } else if (!workoutCheckInToday(gameWeek.workoutDays)) {
          ///* Get the index of the game week to check
          final int gameWeekIndex = gameRoom
              .participants![participantIndex].gameWeekModel
              .indexOf(gameWeek);
          gameWeek.completedWorkoutThisWeek =
              gameWeek.completedWorkoutThisWeek + 1;

          ///* Add check in workout
          gameWeek.workoutDays.add(WorkoutDayModel(
              dateWorkedOut: DateFormat('dd-MM-yyyy').format(DateTime.now())));

          ///* Sent to database
          gameRooms
              .doc(gameRoom.documentId)
              .set(gameRoom.toMap(), SetOptions(merge: true));
          print('Workout has been added');
        }
        return;
      }
    }
  }

  bool weekCheck({required String startDate, required String endDate}) {
    return DateFormat('dd-MM-yyyy').parse(startDate).isBefore(DateTime.now()) &&
        DateFormat('dd-MM-yyyy').parse(endDate).isAfter(DateTime.now());
  }

  bool workoutCheckInToday(List<WorkoutDayModel> workoutDayList) {
    return workoutDayList.contains(WorkoutDayModel(
        dateWorkedOut:
            DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()));
  }

  Future<void> participateInGame(
      {required GameRoomModel gameRoom,
      required UserModel user,
      required BuildContext context}) async {
    final int? playerCommitment = await chooseCommitmentAmount(context);
    if (playerCommitment == null) {
      return;
    } else {
      try {
        if (gameRoom.participants!
            .where((element) => element.email == user.email)
            .isEmpty) {
          gameRoom.participants!.add(ParticipantModel(
              lostAmountPerUnit: gameRoom.buyInAmount! /
                  (playerCommitment * gameRoom.commitmentPeriod!),
              userName: user.userName,
              commitmentAmountInChallenge:
                  playerCommitment * gameRoom.commitmentPeriod!,
              commitmentAmountPerWeek: playerCommitment,
              currentAmountEarned: 0,
              currentAmountHolding: gameRoom.buyInAmount!,
              currentAmountLost: 0,
              email: user.email,
              photoUrl:
                  user.avatarImage.isEmpty ? user.photoUrl : user.avatarImage,
              gameWeekModel: createGameWeekModels(gameRoom)));
          await gameRooms
              .doc(gameRoom.documentId)
              .set(gameRoom.toMap(), SetOptions(merge: true));
        } else {
          log('User is already there');
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  Future<int?> chooseCommitmentAmount(BuildContext context) {
    final List<int> commitmentAmount = [1, 2, 3, 4, 5, 6, 7];
    return showDialog<int>(
        context: context,
        builder: (BuildContext context) => Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorPalette.black,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                      child: Text(
                        'Choose Workout Commitment Per Week',
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(color: ColorPalette.snow, fontSize: 24),
                      ),
                    ),
                    ...commitmentAmount.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    ColorPalette.primaryPurple),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(200, 60))),
                            onPressed: () {
                              Navigator.pop(context, e);
                            },
                            child: Text(
                              e.toString(),
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 16),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ]),
            )));
  }
}
