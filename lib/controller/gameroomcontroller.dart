import 'dart:developer';
import 'dart:math' as MATH;

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

extension Precision on double {
  double toDoublePrecision(int fractionDigits) {
    var mod = MATH.pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).floor().toDouble() / mod);
  }
}

class GameRoomController extends GetxController {
  static GameRoomController get to => Get.find();
  final RxBool gameStart = false.obs;
  final RxList<GameRoomModel> gameRoomList = <GameRoomModel>[].obs;
  final Rx<CreateGame> createGame = CreateGame().obs;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  RxList<GameRoomModel> gameRoomNotStarted = <GameRoomModel>[].obs;

  final RxString currentGameRoomId = ''.obs;
  final RxList<GameRoomModel> participatingGameRoomList = <GameRoomModel>[].obs;
  CollectionReference gameRooms =
      FirebaseFirestore.instance.collection('gamerooms');

  Future<void> controllerSetUp(UserModel user) async {
    //* clear game Rooms - checked
    await clearGameRooms();
    //* get all game rooms - checked
    await getAllGameRoom();
    //* get rooms that participant/user is in
    await getParticipatingGameRooms(user);
    //* get rooms that not Started
    await getGameRoomsNotStarted();
    //* Trigger start game - Checked
    await triggerStartGame();
    //* Trigger end game - Checked
    await triggerEndGame();
    //* Per Week is 6 days
    //* Checked missed workout - checked
    await checkMissedWorkout();
    //! This is to only create a test on firebase
    //  createNewGameRoomTEST();
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

  Future<void> getGameRoomsNotStarted() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      if (gameRoom.started == false) {
        gameRoomNotStarted.add(gameRoom);
      }
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

  Future<void> triggerEndGame() async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      if (DateFormat('dd-MM-yyyy')
          .parse(gameRoom.endDate!)
          .isBefore(DateTime.now())) {
        if (gameRoom.ended == false) {
          gameRoom.ended = true;
        } else {
          return;
        }
      }
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
              .isBefore(DateTime.now())) {
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
        participant.currentAmountHolding = (participant.currentAmountHolding! +
                participant.currentAmountEarned! -
                participant.currentAmountLost!)
            .toDoublePrecision(2);
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
      //! ctrl earnings descripencies
      //*Clear all descripencies
      gameRoom.ctrlEarnings = 0;
      clearEarnedAmount(gameRoom);
      if (gameRoom.started == true) {
        for (int week = 0; week < gameRoom.commitmentPeriod!; week++) {
          final List<ParticipantModel> eligibleParticipant = gameRoom
              .participants!
              .where((element) =>
                  element.gameWeekModel[week].workoutDays.isNotEmpty)
              .toList();
          log('week: $week');
          log('Eligible participant$eligibleParticipant');
          final List<ParticipantModel> inEligibleParticipant = gameRoom
              .participants!
              .where(
                  (element) => element.gameWeekModel[week].workoutDays.isEmpty)
              .toList();
          log('inEligibleParticipant participant$inEligibleParticipant');

          //* The first distribution model plus error handling check
          if (eligibleParticipant.isEmpty) {
            gameRoom.ctrlEarnings = gameRoom.ctrlEarnings! +
                gameRoom.buyInAmount! /
                    gameRoom.commitmentPeriod! *
                    inEligibleParticipant.length;
            log('There is no eligible participant');
          } else if (eligibleParticipant.length == 1) {
            log('There is only 1 eligible particpant');
            gameRoom.ctrlEarnings = gameRoom.ctrlEarnings! +
                eligibleParticipant.first.gameWeekModel[week].lostThisWeek;
            eligibleParticipant.first.gameWeekModel[week].earnedThisweek =
                gameRoom.buyInAmount! /
                    gameRoom.commitmentPeriod! *
                    inEligibleParticipant.length;
          } else if (eligibleParticipant.length > 1) {
            //* distribute with distribution method 1st step
            for (final ParticipantModel participant1 in eligibleParticipant) {
              for (final ParticipantModel participant2 in eligibleParticipant) {
                if (participant1 != participant2) {
                  log(participant2.email);
                  final double formulationOfDistribution =
                      participant1.gameWeekModel[week].lostThisWeek *
                          participant2.commitmentAmountPerWeek /
                          (calculateAllEligibleParticipantUnits(
                                  eligibleParticipant) -
                              participant1.commitmentAmountPerWeek);
                  log('earned' + 'week:' + week.toString());
                  log(formulationOfDistribution.toString());
                  participant2.gameWeekModel[week].earnedThisweek =
                      participant2.gameWeekModel[week].earnedThisweek +
                          formulationOfDistribution;
                }
              }
            }
            //* 2nd step distribute all not eligible into this
            for (final ParticipantModel participant in eligibleParticipant) {
              participant.gameWeekModel[week].earnedThisweek =
                  participant.gameWeekModel[week].earnedThisweek +
                      gameRoom.buyInAmount! /
                          gameRoom.commitmentPeriod! *
                          inEligibleParticipant.length /
                          calculateAllEligibleParticipantUnits(
                              eligibleParticipant) *
                          participant.commitmentAmountPerWeek;
            }
            //* All ineligible participant 0
          }
        }
      }
    }
  }

  void clearEarnedAmount(GameRoomModel gameRoom) {
    for (final ParticipantModel participant in gameRoom.participants!) {
      for (final GameWeekModel gameWeek in participant.gameWeekModel) {
        gameWeek.earnedThisweek = 0;
      }
    }
  }

  int calculateAllEligibleParticipantUnits(
      final List<ParticipantModel> partcipants) {
    int totalUnits = 0;
    for (final ParticipantModel participant in partcipants) {
      totalUnits = totalUnits + participant.commitmentAmountPerWeek;
    }

    return totalUnits;
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
          startDate: DateFormat('dd-MM-yyyy')
              .format(createGame.value.startPeriod!)
              .toString(),
          started: false,
          commitmentPeriod: createGame.value.commitmentPeriod,
          gameCreatorEmail: createGame.value.gameCreatorEmail,
          roomLimit: createGame.value.roomLimit,
          ctrlEarnings: 0,
          ended: false,
        );
        await gameRooms.doc().set(createNewGameRoom.toMap());
        await showDialog(
            context: context,
            builder: (context) {
              return const Dialog(
                child: Text('Room is created'),
              );
            });
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
          .add(Duration(days: (i * 6) + i));

      final DateTime endDate = DateFormat('dd-MM-yyyy')
          .parse(gameRoom.startDate!)
          .add(Duration(days: (i + 1) * 7 - 1));

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

  Future<void> workoutCheckin(
      GameRoomModel gameRoom, UserModel user, BuildContext context) async {
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
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                color: ColorPalette.black,
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'You have already checked in for today \n\nSee you next workout!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
              ),
            ),
          );

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
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Container(
                color: ColorPalette.black,
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'Checked in Successfully. \n Great work! Keep it up!',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
              ),
            ),
          );
        }
        return;
      }
    }
  }

  Future<void> checkInAllGames(BuildContext context) async {
    for (final GameRoomModel gameRoom in gameRoomList) {
      await workoutCheckin(
          gameRoom, authenticationController.user.value, context);
    }
  }

  Future<void> clearGameRooms() async {
    gameRoomList.value = <GameRoomModel>[].obs;
    participatingGameRoomList.value = <GameRoomModel>[].obs;
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
    try {
      if (gameRoom.participants!
          .where((element) => element.email == user.email)
          .isEmpty) {
        //* check user wallet amount
        if (user.walletAmount < gameRoom.buyInAmount!) {
          showDialog(
              context: context,
              builder: (BuildContext context) => const Dialog(
                    backgroundColor: ColorPalette.black,
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'Your current balance is not enough, Please Top Up',
                        style: TextStyle(color: ColorPalette.snow),
                      ),
                    ),
                  ));
        } else {
          final int? playerCommitment = await chooseCommitmentAmount(context);
          if (playerCommitment == null) {
            return;
          } else {
            user.walletAmount = user.walletAmount - gameRoom.buyInAmount!;
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
            participatingGameRoomList.add(gameRoom);
            authenticationController.updateDocument();
            gameRoomList.refresh();
            // participatingGameRoomList.refresh();
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => const Dialog(
                  backgroundColor: ColorPalette.black,
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      'You have already joined the game, Please wait for it to start',
                      style: TextStyle(color: ColorPalette.snow),
                    ),
                  ),
                ));
        log('User is already there');
      }
    } catch (e) {
      log(e.toString());
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

  //! Send out test game room to firebase
  Future<void> createNewGameRoomTEST() async {
    final GameRoomModel gameRoomModel = GameRoomModel(
      buyInAmount: 500,
      commitmentPeriod: 8,
      documentId: '123456',
      endDate: '24-03-2021',
      gameCreatorEmail: 'Jazsleyzainal@gmail.com',
      id: '1',
      name: 'gameTest1',
      participants: [
        //* Player A
        ParticipantModel(
          commitmentAmountInChallenge: 16,
          commitmentAmountPerWeek: 2,
          currentAmountEarned: 0,
          currentAmountHolding: 500,
          currentAmountLost: 0,
          email: '',
          lostAmountPerUnit: 31.25,
          photoUrl: '',
          userName: 'Player A',
          gameWeekModel: [
            //* Week 1
            GameWeekModel(
                startDate: '27-01-2021',
                endDate: '02-02-2021',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2021')
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2021',
                endDate: '09-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 62.50,
                workoutDays: []),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2021',
                endDate: '16-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2021',
                endDate: '23-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2021',
                endDate: '02-03-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2021',
                endDate: '09-03-2021',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2021')
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2021',
                endDate: '16-03-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '11-03-2021')]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2021',
                endDate: '23-03-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '18-03-2021')]),
          ],
        ),
        //* Player B
        ParticipantModel(
          commitmentAmountInChallenge: 40,
          commitmentAmountPerWeek: 5,
          currentAmountEarned: 0,
          currentAmountHolding: 500,
          currentAmountLost: 0,
          email: '',
          lostAmountPerUnit: 12.50,
          photoUrl: '',
          userName: 'Player B',
          gameWeekModel: [
            //* Week 1
            GameWeekModel(
                startDate: '27-01-2021',
                endDate: '02-02-2021',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '30-01-2021'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2021',
                endDate: '09-02-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '04-02-2021')]),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2021',
                endDate: '16-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 5,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2021',
                endDate: '23-02-2021',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '18-02-2021'),
                  WorkoutDayModel(dateWorkedOut: '19-02-2021'),
                ]),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2021',
                endDate: '02-03-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 5,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2021',
                endDate: '09-03-2021',
                completedWorkoutThisWeek: 5,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '06-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '07-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '08-03-2022'),
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2021',
                endDate: '16-03-2021',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '11-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '12-03-2022'),
                ]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2021',
                endDate: '23-03-2021',
                completedWorkoutThisWeek: 4,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '18-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '19-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '20-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '21-03-2022'),
                ]),
          ],
        ),
        //* Player C
        ParticipantModel(
          commitmentAmountInChallenge: 32,
          commitmentAmountPerWeek: 4,
          currentAmountEarned: 0,
          currentAmountHolding: 500,
          currentAmountLost: 0,
          email: '',
          lostAmountPerUnit: 125 / 8,
          photoUrl: '',
          userName: 'Player C',
          gameWeekModel: [
            //* Week 1
            GameWeekModel(
                startDate: '27-01-2021',
                endDate: '02-02-2021',
                completedWorkoutThisWeek: 4,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '30-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '01-02-2021'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2021',
                endDate: '09-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2021',
                endDate: '16-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2021',
                endDate: '23-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2021',
                endDate: '02-03-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2021',
                endDate: '09-03-2021',
                completedWorkoutThisWeek: 4,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '06-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '07-03-2021'),
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2021',
                endDate: '16-03-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '11-03-2021')]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2021',
                endDate: '23-03-2021',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '19-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '20-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '21-03-2021'),
                ]),
          ],
        ),
        //* Player D
        ParticipantModel(
          commitmentAmountInChallenge: 24,
          commitmentAmountPerWeek: 3,
          currentAmountEarned: 0,
          currentAmountHolding: 500,
          currentAmountLost: 0,
          email: '',
          lostAmountPerUnit: 125 / 6,
          photoUrl: '',
          userName: 'Player D',
          gameWeekModel: [
            //* Week 1
            GameWeekModel(
                startDate: '27-01-2021',
                endDate: '02-02-2021',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2021'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2021'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2021',
                endDate: '09-02-2021',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-02-2021'),
                  WorkoutDayModel(dateWorkedOut: '05-02-2021'),
                  WorkoutDayModel(dateWorkedOut: '06-02-2021'),
                ]),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2021',
                endDate: '16-02-2021',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '11-02-2021'),
                  WorkoutDayModel(dateWorkedOut: '12-02-2021'),
                  WorkoutDayModel(dateWorkedOut: '13-02-2021'),
                ]),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2021',
                endDate: '23-02-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2021',
                endDate: '02-03-2021',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2021',
                endDate: '09-03-2021',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2021'),
                  WorkoutDayModel(dateWorkedOut: '06-03-2021'),
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2021',
                endDate: '16-03-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '11-03-2022'),
                ]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2021',
                endDate: '23-03-2021',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '18-03-2021')]),
          ],
        )
      ],
      potAmount: 1000,
      roomLimit: 4,
      startDate: '27-01-2021',
      started: true,
      ctrlEarnings: 0,
      ended: false,
    );
    gameRooms.doc('123456').set(gameRoomModel.toMap());
  }
}
