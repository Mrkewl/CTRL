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
  final RxList<GameRoomModel> participatingGameRoomList = <GameRoomModel>[].obs;
  CollectionReference gameRooms =
      FirebaseFirestore.instance.collection('gamerooms');

  Future<void> controllerSetUp(UserModel user) async {
    await getAllGameRoom();
    await getParticipatingGameRooms(user);
    await triggerStartGame();
    await checkMissedWorkout();
    await getListEachParticipantAmountLossAtEndWeek();
    await distributeLostAmountToParticipants();
    await getTotalAmountEarnedInGame();
    await getTotalAmountLostInGame();
    await getCurrentAmountHolding();
    await updateDocumentInStorage();
  }

  Future<void> getAllGameRoom() async {
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

  Future<void> getParticipatingGameRooms(UserModel user) async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        if (participant.email == user.email) {
          participatingGameRoomList.add(gameRoom);
        }
      }
    }
  }

  Future<void> updateDocumentInStorage() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      gameRooms.doc(gameRoom.documentId).update(gameRoom.toMap());
    }
  }

  Future<void> triggerStartGame() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      if (weekCheck(
          startDate: gameRoom.startDate!, endDate: gameRoom.endDate!)) {
        if (gameRoom.started == false) {
          gameRoom.started = true;
        } else {
          return;
        }
      }
    }
  }

  Future<void> updatePotAmount(GameRoomModel gameRoom) async {
    final double totalPotAmount =
        gameRoom.participants!.length * gameRoom.buyInAmount!;
    gameRooms.doc(gameRoom.documentId).update({'potAmount': totalPotAmount});
  }

  Future<void> checkMissedWorkout() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          if (DateFormat('dd-MM-yyyy')
                  .parse(gameWeek.endDate)
                  .isBefore(DateTime.now()) ||
              DateFormat('dd-MM-yyyy')
                  .parse(gameWeek.endDate)
                  .isAtSameMomentAs(DateTime.now())) {
            if (gameWeek.workoutDays.length <
                participant.commitmentAmountPerWeek) {
              gameWeek.missedWorkoutThisWeek =
                  participant.commitmentAmountPerWeek -
                      gameWeek.workoutDays.length;
            } else if (gameWeek.workoutDays.length >=
                participant.commitmentAmountPerWeek) {
              gameWeek.missedWorkoutThisWeek = 0;
              log(gameWeek.missedWorkoutThisWeek.toString());
            } else {
              log('hello');
            }
          }
        }
      }
    }
  }

  //Get total amount of units
  Future<int> totalAmountOfUnits(GameRoomModel gameRoom) async {
    int totalUnits = 0;
    for (final ParticipantModel participant in gameRoom.participants!) {
      totalUnits = totalUnits + participant.commitmentAmountPerWeek;
    }
    return totalUnits;
  }

  //Get Total amount of loss for each participant in each week
  Future<void> getListEachParticipantAmountLossAtEndWeek() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          gameWeek.lostThisWeek =
              participant.lostAmountPerUnit * gameWeek.missedWorkoutThisWeek;
        }
      }
    }
  }

  Future<void> getTotalAmountEarnedInGame() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        participant.currentAmountEarned = 0;
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          participant.currentAmountEarned =
              participant.currentAmountEarned! + gameWeek.earnedThisweek;
        }
      }
    }
  }

  Future<void> getTotalAmountLostInGame() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        participant.currentAmountLost = 0;
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          participant.currentAmountLost =
              participant.currentAmountLost! + gameWeek.lostThisWeek;
        }
      }
    }
  }

  Future<void> getCurrentAmountHolding() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        participant.currentAmountHolding = gameRoom.buyInAmount;
        participant.currentAmountHolding = participant.currentAmountHolding! +
            participant.currentAmountEarned! -
            participant.currentAmountLost!;
      }
    }
  }

  double getUserAmountHolding(UserModel user, GameRoomModel gameRoom) {
    final ParticipantModel currentUser = gameRoom.participants!
        .firstWhere((element) => element.email == user.email);
    return gameRoom.buyInAmount! -
        currentUser.currentAmountLost! +
        currentUser.currentAmountEarned!;
  }

  ParticipantModel getParticipantData(GameRoomModel gameRoom, UserModel user) {
    return gameRoom.participants!
        .firstWhere((element) => element.email == user.email);
  }

  String getWeeksLeft(GameRoomModel gameRoom) {
    final Duration durationLeft = DateFormat('dd-MM-yyyy')
        .parse(gameRoom.endDate!)
        .difference(DateTime.now());
    return 'Week/Weeks: ${(durationLeft.inDays / 7).toStringAsFixed(0)}\nDays: ${(durationLeft.inDays % 7).toStringAsFixed(0)}';
  }

  Future<void> distributeLostAmountToParticipants() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      await clearAllEarnedAmount(gameRoom);

      ///TODO to write method to clear all earned this week first.
      ///*This method will calculate all weeks for the game room to distribute
      for (final ParticipantModel participant1 in gameRoom.participants!) {
        int count = 0;
        for (final GameWeekModel gameWeek in participant1.gameWeekModel) {
          log('----------------');
          log(participant1.email);
          log('Loss this week');
          log(gameWeek.lostThisWeek.toString());
          for (final ParticipantModel participant2 in gameRoom.participants!) {
            if (participant1 != participant2) {
              log(participant2.email);
              final double formulationOfDistribution = gameWeek.lostThisWeek *
                  participant2.commitmentAmountPerWeek /
                  (await totalAmountOfUnits(gameRoom) -
                      participant1.commitmentAmountPerWeek);
              log('earned' + 'week:' + count.toString());
              log(formulationOfDistribution.toString());
              participant2.gameWeekModel[count].earnedThisweek =
                  participant2.gameWeekModel[count].earnedThisweek +
                      formulationOfDistribution;
            }
          }
          count++;
        }
      }
    }
  }

  Future<void> clearAllEarnedAmount(GameRoomModel gameRoom) async {
    for (final ParticipantModel participant in gameRoom.participants!) {
      for (final GameWeekModel gameWeek in participant.gameWeekModel) {
        gameWeek.earnedThisweek = 0;
      }
    }
  }

  Future<void> individuallossAmountPerWeek(GameRoomModel gameRoom) async {
    for (final ParticipantModel participant in gameRoom.participants!) {
      for (final GameWeekModel gameWeek in participant.gameWeekModel) {
        log((gameWeek.lostThisWeek =
                participant.lostAmountPerUnit * gameWeek.missedWorkoutThisWeek)
            .toString());
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
        await getAllGameRoom();
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
    log(participantIndex.toString());

    ///*This is to check which week
    for (final GameWeekModel gameWeek
        in gameRoom.participants![participantIndex].gameWeekModel) {
      if (weekCheck(startDate: gameWeek.startDate, endDate: gameWeek.endDate)) {
        ///*This is to check if user has worked out today
        if (workoutCheckInToday(gameWeek.workoutDays)) {
          log('You have already worked out today');
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
          log('Workout has been added');
        }
        return;
      }
    }
  }

  Future<void> checkInAllGames() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      await workoutCheckin(gameRoom, authenticationController.user.value);
    }
  }

  GameWeekModel getGameWeek(GameRoomModel gameRoom, UserModel user) {
    late GameWeekModel currentGameWeek;
    final int participantIndex = gameRoom.participants!
        .indexWhere((element) => element.email == user.email);
    for (final GameWeekModel gameWeek
        in gameRoom.participants![participantIndex].gameWeekModel) {
      if (weekCheck(startDate: gameWeek.startDate, endDate: gameWeek.endDate)) {
        currentGameWeek = gameWeek;
      }
    }
    return currentGameWeek;
  }

  /// Can put in Extension
  bool weekCheck({required String startDate, required String endDate}) {
    return DateFormat('dd-MM-yyyy').parse(startDate).isBefore(DateTime.now()) &&
        DateFormat('dd-MM-yyyy').parse(endDate).isAfter(DateTime.now());
  }

  bool workoutCheckInToday(List<WorkoutDayModel> workoutDayList) {
    return workoutDayList.contains(WorkoutDayModel(
        dateWorkedOut:
            DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()));
  }

//User to join game
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
              currentAmountHolding: gameRoom.buyInAmount,
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
