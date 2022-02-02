import 'dart:developer';

import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/models/gameweek_model.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:ctrl_app/models/workoutday_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('Game Distribution', () async {
    final GameRoomModel gameRoomModel = GameRoomModel(
      buyInAmount: 500,
      commitmentPeriod: 8,
      documentId: '123456',
      endDate: DateFormat('dd-MM-yyyy')
          .parse('27-01-2022')
          .add(const Duration(days: 56))
          .toString(),
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
                startDate: '27-01-2022',
                endDate: '03-02-2022',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2022'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2022',
                endDate: '10-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 62.50,
                workoutDays: []),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2022',
                endDate: '17-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2022',
                endDate: '24-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2022',
                endDate: '03-03-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2022',
                endDate: '10-03-2022',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2022')
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2022',
                endDate: '17-03-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '11-03-2022')]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2022',
                endDate: '24-03-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '18-03-2022')]),
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
                startDate: '27-01-2022',
                endDate: '03-02-2022',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '30-01-2022'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2022',
                endDate: '10-02-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '04-02-2022')]),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2022',
                endDate: '17-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 5,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2022',
                endDate: '24-02-2022',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '18-02-2022'),
                  WorkoutDayModel(dateWorkedOut: '19-02-2022'),
                ]),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2022',
                endDate: '03-03-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 5,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2022',
                endDate: '10-03-2022',
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
                startDate: '10-03-2022',
                endDate: '17-03-2022',
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
                startDate: '17-03-2022',
                endDate: '24-03-2022',
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
                startDate: '27-01-2022',
                endDate: '03-02-2022',
                completedWorkoutThisWeek: 4,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '01-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '02-01-2022'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2022',
                endDate: '10-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2022',
                endDate: '17-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2022',
                endDate: '24-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2022',
                endDate: '03-03-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 4,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2022',
                endDate: '10-03-2022',
                completedWorkoutThisWeek: 4,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '06-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '07-03-2022'),
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2022',
                endDate: '17-03-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '11-03-2022')]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2022',
                endDate: '24-03-2022',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '19-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '20-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '21-03-2022'),
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
                startDate: '27-01-2022',
                endDate: '03-02-2022',
                completedWorkoutThisWeek: 2,
                missedWorkoutThisWeek: 1,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '28-01-2022'),
                  WorkoutDayModel(dateWorkedOut: '29-01-2022'),
                ]),
            //* Week 2
            GameWeekModel(
                startDate: '03-02-2022',
                endDate: '10-02-2022',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-02-2022'),
                  WorkoutDayModel(dateWorkedOut: '05-02-2022'),
                  WorkoutDayModel(dateWorkedOut: '06-02-2022'),
                ]),
            //* Week 3
            GameWeekModel(
                startDate: '10-02-2022',
                endDate: '17-02-2022',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '11-02-2022'),
                  WorkoutDayModel(dateWorkedOut: '12-02-2022'),
                  WorkoutDayModel(dateWorkedOut: '13-02-2022'),
                ]),
            //* Week 4
            GameWeekModel(
                startDate: '17-02-2022',
                endDate: '24-02-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 5
            GameWeekModel(
                startDate: '24-02-2022',
                endDate: '03-03-2022',
                completedWorkoutThisWeek: 0,
                missedWorkoutThisWeek: 3,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: []),
            //* Week 6
            GameWeekModel(
                startDate: '03-03-2022',
                endDate: '10-03-2022',
                completedWorkoutThisWeek: 3,
                missedWorkoutThisWeek: 0,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '04-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '05-03-2022'),
                  WorkoutDayModel(dateWorkedOut: '06-03-2022'),
                ]),
            //* Week 7
            GameWeekModel(
                startDate: '10-03-2022',
                endDate: '17-03-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [
                  WorkoutDayModel(dateWorkedOut: '11-03-2022'),
                ]),
            //* Week 8
            GameWeekModel(
                startDate: '17-03-2022',
                endDate: '24-03-2022',
                completedWorkoutThisWeek: 1,
                missedWorkoutThisWeek: 2,
                earnedThisweek: 0,
                lostThisWeek: 0,
                workoutDays: [WorkoutDayModel(dateWorkedOut: '18-03-2022')]),
          ],
        )
      ],
      potAmount: 1000,
      roomLimit: 4,
      startDate: '27-01-2022',
      started: true,
      ctrlEarnings: 0,
      ended: false,
    );
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

    Future<void> getListEachParticipantAmountLossAtEndWeek() async {
      final GameRoomModel gameRoom = gameRoomModel;
      for (final ParticipantModel participant in gameRoom.participants!) {
        for (final GameWeekModel gameWeek in participant.gameWeekModel) {
          gameWeek.lostThisWeek =
              participant.lostAmountPerUnit * gameWeek.missedWorkoutThisWeek;
        }
      }
    }

    Future<void> distributeLostAmountToParticipants() async {
      final GameRoomModel gameRoom = gameRoomModel;

      //*Clear all descripencies
      clearEarnedAmount(gameRoom);
      for (int week = 0; week < gameRoom.commitmentPeriod!; week++) {
        final List<ParticipantModel> eligibleParticipant = gameRoom
            .participants!
            .where(
                (element) => element.gameWeekModel[week].workoutDays.isNotEmpty)
            .toList();
        log('week: $week');
        log('Eligible participant$eligibleParticipant');
        final List<ParticipantModel> inEligibleParticipant = gameRoom
            .participants!
            .where((element) => element.gameWeekModel[week].workoutDays.isEmpty)
            .toList();
        log('inEligibleParticipant participant$inEligibleParticipant');

        //* The first distribution model plus error handling check
        if (eligibleParticipant.isEmpty) {
          log('There is no eligible participant');
          gameRoom.ctrlEarnings = gameRoom.ctrlEarnings! +
              gameRoom.buyInAmount! /
                  gameRoom.commitmentPeriod! *
                  inEligibleParticipant.length;
          // print('week: ' + week.toString());
          // print(eligibleParticipant.length);
        } else if (eligibleParticipant.length == 1) {
          gameRoom.ctrlEarnings = gameRoom.ctrlEarnings! +
              eligibleParticipant.first.gameWeekModel[week].lostThisWeek;
          log('There is only 1 eligible particpant');
          eligibleParticipant.first.gameWeekModel[week].earnedThisweek =
              gameRoom.buyInAmount! /
                  gameRoom.commitmentPeriod! *
                  inEligibleParticipant.length;
          // print('week: ' + week.toString());
          // print(eligibleParticipant.length);
        } else if (eligibleParticipant.length > 1) {
          //* distribute with distribution method 1st step
          for (final ParticipantModel participant1 in eligibleParticipant) {
            for (final ParticipantModel participant2 in eligibleParticipant) {
              if (participant1 != participant2) {
                log(participant2.email);
                final double formulationOfDistribution = participant1
                        .gameWeekModel[week].lostThisWeek *
                    participant2.commitmentAmountPerWeek /
                    (calculateAllEligibleParticipantUnits(eligibleParticipant) -
                        participant1.commitmentAmountPerWeek);
                log('earned' + 'week:' + week.toString());
                log(formulationOfDistribution.toString());
                participant2.gameWeekModel[week].earnedThisweek =
                    participant2.gameWeekModel[week].earnedThisweek +
                        formulationOfDistribution;
                // print('earned' + 'week:' + week.toString());
                // print(participant2.userName);
                // print(participant2.gameWeekModel[week].earnedThisweek);
              }
            }
          }
          //* 2nd step distribute all not eligible into this
          for (final ParticipantModel participant in eligibleParticipant) {
            participant.gameWeekModel[week].earnedThisweek = participant
                    .gameWeekModel[week].earnedThisweek +
                gameRoom.buyInAmount! /
                    gameRoom.commitmentPeriod! *
                    inEligibleParticipant.length /
                    calculateAllEligibleParticipantUnits(eligibleParticipant) *
                    participant.commitmentAmountPerWeek;
          }
          //* All ineligible participant 0
        }
      }
    }

    void calculateCTRLearnings(
        GameRoomModel gameRoom, List<ParticipantModel> ineligibleparticipant) {
      if (ineligibleparticipant.length == gameRoom.participants!.length) {
        gameRoom.ctrlEarnings = gameRoom.ctrlEarnings! +
            gameRoom.buyInAmount! * ineligibleparticipant.length;
      }
    }

    await getListEachParticipantAmountLossAtEndWeek();
    await distributeLostAmountToParticipants();

    log(gameRoomModel.toString());
    //* Player name TEst
    expect(gameRoomModel.participants![0].userName, 'Player A',
        reason: 'Player A name pass');
    expect(gameRoomModel.participants![1].userName, 'Player B',
        reason: 'Player B name pass');
    expect(gameRoomModel.participants![2].userName, 'Player C',
        reason: 'Player C name pass');
    expect(gameRoomModel.participants![3].userName, 'Player D',
        reason: 'Player D name pass');
    //* Player week 1 loss
    expect(gameRoomModel.participants![0].gameWeekModel[0].lostThisWeek, 0,
        reason: 'Player A Week 1 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[0].lostThisWeek, 25,
        reason: 'Player B Week 1 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[0].lostThisWeek, 0,
        reason: 'Player C Week 1 Loss');
    expect(
        gameRoomModel.participants![3].gameWeekModel[0].lostThisWeek, 125 / 6,
        reason: 'Player D Week 1 Loss');
    //* Player week 2 loss
    expect(gameRoomModel.participants![0].gameWeekModel[1].lostThisWeek, 62.50,
        reason: 'Player A Week 2 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[1].lostThisWeek, 50,
        reason: 'Player B Week 2 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[1].lostThisWeek, 62.50,
        reason: 'Player C Week 2 Loss');
    expect(gameRoomModel.participants![3].gameWeekModel[1].lostThisWeek, 0,
        reason: 'Player D Week 2 Loss');
    //* Player week 3 loss
    expect(gameRoomModel.participants![0].gameWeekModel[2].lostThisWeek, 62.50,
        reason: 'Player A Week 3 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[2].lostThisWeek, 62.50,
        reason: 'Player B Week 3 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[2].lostThisWeek, 62.50,
        reason: 'Player C Week 3 Loss');
    expect(gameRoomModel.participants![3].gameWeekModel[2].lostThisWeek, 0,
        reason: 'Player D Week 3 Loss');
    //* Player week 4 loss
    expect(gameRoomModel.participants![0].gameWeekModel[3].lostThisWeek, 62.50,
        reason: 'Player A Week 4 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[3].lostThisWeek, 37.50,
        reason: 'Player B Week 4 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[3].lostThisWeek, 62.50,
        reason: 'Player C Week 4 Loss');
    expect(gameRoomModel.participants![3].gameWeekModel[3].lostThisWeek, 62.50,
        reason: 'Player D Week 4 Loss');
    //* Player week 5 loss
    expect(gameRoomModel.participants![0].gameWeekModel[4].lostThisWeek, 62.50,
        reason: 'Player A Week 5 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[4].lostThisWeek, 62.50,
        reason: 'Player B Week 5 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[4].lostThisWeek, 62.50,
        reason: 'Player C Week 5 Loss');
    expect(gameRoomModel.participants![3].gameWeekModel[4].lostThisWeek, 62.50,
        reason: 'Player D Week 5 Loss');
    //* Player week 3 loss
    expect(gameRoomModel.participants![0].gameWeekModel[5].lostThisWeek, 0,
        reason: 'Player A Week 6 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[5].lostThisWeek, 0,
        reason: 'Player B Week 6 Loss');
    expect(gameRoomModel.participants![2].gameWeekModel[5].lostThisWeek, 0,
        reason: 'Player C Week 6 Loss');
    expect(gameRoomModel.participants![3].gameWeekModel[5].lostThisWeek, 0,
        reason: 'Player D Week 6 Loss');
    //* Player week 7 loss
    expect(gameRoomModel.participants![0].gameWeekModel[6].lostThisWeek, 31.25,
        reason: 'Player A Week 7 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[6].lostThisWeek, 37.5,
        reason: 'Player B Week 7 Loss');
    expect(
        gameRoomModel.participants![2].gameWeekModel[6].lostThisWeek, 375 / 8,
        reason: 'Player C Week 7 Loss');
    expect(
        gameRoomModel.participants![3].gameWeekModel[6].lostThisWeek, 125 / 3,
        reason: 'Player D Week 7 Loss');
    //* Player week 8 loss
    expect(gameRoomModel.participants![0].gameWeekModel[7].lostThisWeek, 31.25,
        reason: 'Player A Week 8 Loss');
    expect(gameRoomModel.participants![1].gameWeekModel[7].lostThisWeek, 12.50,
        reason: 'Player B Week 8 Loss');
    expect(
        gameRoomModel.participants![2].gameWeekModel[7].lostThisWeek, 62.5 / 4,
        reason: 'Player C Week 8 Loss');
    expect(
        gameRoomModel.participants![3].gameWeekModel[7].lostThisWeek, 125 / 3,
        reason: 'Player D Week 8 Loss');

    // //* Player week 1 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[0].earnedThisweek,
        (50 / 9) + 0 + (125 / 33),
        reason: 'Player A Week 1 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[0].earnedThisweek,
        625 / 66,
        reason: 'Player B Week 1 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[0].earnedThisweek,
        100 / 9 + 250 / 33,
        reason: 'Player C Week 1 Earnings');
    expect(
        gameRoomModel.participants![3].gameWeekModel[0].earnedThisweek, 25 / 3,
        reason: 'Player D Week 1 Earnings');

    //* Player week 2 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[1].earnedThisweek, 0,
        reason: 'Player A Week 2 Earnings');
    expect(
        gameRoomModel.participants![1].gameWeekModel[1].earnedThisweek, 78.125,
        reason: 'Player B Week 2 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[1].earnedThisweek, 0,
        reason: 'Player C Week 2 Earnings');
    expect(
        gameRoomModel.participants![3].gameWeekModel[1].earnedThisweek, 96.875,
        reason: 'Player D Week 2 Earnings');

    //* Player week 3 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[2].earnedThisweek, 0,
        reason: 'Player A Week 3 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[2].earnedThisweek, 0,
        reason: 'Player B Week 3 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[2].earnedThisweek, 0,
        reason: 'Player C Week 3 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[2].earnedThisweek,
        62.5 * 3,
        reason: 'Player D Week 3 Earnings');

    // //* Player week 4 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[3].earnedThisweek, 0,
        reason: 'Player A Week 4 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[3].earnedThisweek,
        62.5 * 3,
        reason: 'Player B Week 4 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[3].earnedThisweek, 0,
        reason: 'Player C Week 4 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[3].earnedThisweek, 0,
        reason: 'Player D Week 4 Earnings');

    // //* Player week 5 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[4].earnedThisweek, 0,
        reason: 'Player A Week 5 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[4].earnedThisweek, 0,
        reason: 'Player B Week 5 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[4].earnedThisweek, 0,
        reason: 'Player C Week 5 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[4].earnedThisweek, 0,
        reason: 'Player D Week 5 Earnings');

    // //* Player week 6 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[5].earnedThisweek, 0,
        reason: 'Player A Week 6 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[5].earnedThisweek, 0,
        reason: 'Player B Week 6 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[5].earnedThisweek, 0,
        reason: 'Player C Week 6 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[5].earnedThisweek, 0,
        reason: 'Player D Week 6 Earnings');

    // //* Player week 7 earnings
    expect(gameRoomModel.participants![0].gameWeekModel[6].earnedThisweek,
        double.parse((25 / 3 + 75 / 8 + 250 / 33).toStringAsFixed(14)),
        reason: 'Player A Week 7 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[6].earnedThisweek,
        625 / 48 + 375 / 16 + 625 / 33,
        reason: 'Player B Week 7 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[6].earnedThisweek,
        125 / 12 + 50 / 3 + 500 / 33,
        reason: 'Player C Week 7 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[6].earnedThisweek,
        125 / 16 + 12.5 + 225 / 16,
        reason: 'Player D Week 7 Earnings');

    // //* Player week 8 earnings
    expect(
        double.parse(gameRoomModel
            .participants![0].gameWeekModel[7].earnedThisweek
            .toStringAsFixed(15)),
        25 / 9 + 25 / 8 + 250 / 33,
        reason: 'Player A Week 8 Earnings');
    expect(gameRoomModel.participants![1].gameWeekModel[7].earnedThisweek,
        625 / 48 + 125 / 16 + 625 / 33,
        reason: 'Player B Week 8 Earnings');
    expect(gameRoomModel.participants![2].gameWeekModel[7].earnedThisweek,
        double.parse((125 / 12 + 50 / 9 + 500 / 33).toStringAsFixed(14)),
        reason: 'Player C Week 8 Earnings');
    expect(gameRoomModel.participants![3].gameWeekModel[7].earnedThisweek,
        125 / 16 + 25 / 6 + 75 / 16,
        reason: 'Player D Week 8 Earnings');

    expect(gameRoomModel.ctrlEarnings, 287.50,
        reason: 'Player D Week 8 Earnings');
  });
}
