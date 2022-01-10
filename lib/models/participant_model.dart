// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'gameweek_model.dart';

class ParticipantModel {
  final String email;
  final int commitmentAmountPerWeek;
   double? currentAmountHolding;
   double? currentAmountEarned;
   double? currentAmountLost;
  final int commitmentAmountInChallenge;
  final String userName;
  final String photoUrl;
  final List<GameWeekModel> gameWeekModel;
  final double lostAmountPerUnit;
  ParticipantModel({
    required this.email,
    required this.commitmentAmountPerWeek,
    required this.currentAmountHolding,
    required this.currentAmountEarned,
    required this.currentAmountLost,
    required this.commitmentAmountInChallenge,
    required this.userName,
    required this.photoUrl,
    required this.gameWeekModel,
    required this.lostAmountPerUnit,
  });

  int get totalMissedWorkout {
    int acumulatedMissedWorkout = 0;
    for (final GameWeekModel gameWeek in gameWeekModel) {
      acumulatedMissedWorkout =
          acumulatedMissedWorkout + gameWeek.missedWorkoutThisWeek;
    }
    return acumulatedMissedWorkout;
  }

  ParticipantModel copyWith({
    String? email,
    int? commitmentAmountPerWeek,
    double? currentAmountHolding,
    double? currentAmountEarned,
    double? currentAmountLost,
    int? commitmentAmountInChallenge,
    String? userName,
    String? photoUrl,
    List<GameWeekModel>? gameWeekModel,
    double? lostAmountPerUnit,
  }) {
    return ParticipantModel(
      email: email ?? this.email,
      commitmentAmountPerWeek: commitmentAmountPerWeek ?? this.commitmentAmountPerWeek,
      currentAmountHolding: currentAmountHolding ?? this.currentAmountHolding,
      currentAmountEarned: currentAmountEarned ?? this.currentAmountEarned,
      currentAmountLost: currentAmountLost ?? this.currentAmountLost,
      commitmentAmountInChallenge: commitmentAmountInChallenge ?? this.commitmentAmountInChallenge,
      userName: userName ?? this.userName,
      photoUrl: photoUrl ?? this.photoUrl,
      gameWeekModel: gameWeekModel ?? this.gameWeekModel,
      lostAmountPerUnit: lostAmountPerUnit ?? this.lostAmountPerUnit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'commitmentAmountPerWeek': commitmentAmountPerWeek,
      'currentAmountHolding': currentAmountHolding,
      'currentAmountEarned': currentAmountEarned,
      'currentAmountLost': currentAmountLost,
      'commitmentAmountInChallenge': commitmentAmountInChallenge,
      'userName': userName,
      'photoUrl': photoUrl,
      'gameWeekModel': gameWeekModel.map((x) => x.toMap()).toList(),
      'lostAmountPerUnit': lostAmountPerUnit,
    };
  }

  factory ParticipantModel.fromMap(Map<String, dynamic> map) {
    return ParticipantModel(
      email: map['email'] ?? '',
      commitmentAmountPerWeek: map['commitmentAmountPerWeek']?.toInt() ?? 0,
      currentAmountHolding: map['currentAmountHolding']?.toDouble(),
      currentAmountEarned: map['currentAmountEarned']?.toDouble(),
      currentAmountLost: map['currentAmountLost']?.toDouble(),
      commitmentAmountInChallenge: map['commitmentAmountInChallenge']?.toInt() ?? 0,
      userName: map['userName'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      gameWeekModel: List<GameWeekModel>.from(map['gameWeekModel']?.map((x) => GameWeekModel.fromMap(x))),
      lostAmountPerUnit: map['lostAmountPerUnit']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParticipantModel.fromJson(String source) =>
      ParticipantModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ParticipantModel(email: $email, commitmentAmountPerWeek: $commitmentAmountPerWeek, currentAmountHolding: $currentAmountHolding, currentAmountEarned: $currentAmountEarned, currentAmountLost: $currentAmountLost, commitmentAmountInChallenge: $commitmentAmountInChallenge, userName: $userName, photoUrl: $photoUrl, gameWeekModel: $gameWeekModel, lostAmountPerUnit: $lostAmountPerUnit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ParticipantModel &&
        other.email == email &&
        other.commitmentAmountPerWeek == commitmentAmountPerWeek &&
        other.currentAmountHolding == currentAmountHolding &&
        other.currentAmountEarned == currentAmountEarned &&
        other.currentAmountLost == currentAmountLost &&
        other.commitmentAmountInChallenge == commitmentAmountInChallenge &&
        other.userName == userName &&
        other.photoUrl == photoUrl &&
        listEquals(other.gameWeekModel, gameWeekModel) &&
        other.lostAmountPerUnit == lostAmountPerUnit;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        commitmentAmountPerWeek.hashCode ^
        currentAmountHolding.hashCode ^
        currentAmountEarned.hashCode ^
        currentAmountLost.hashCode ^
        commitmentAmountInChallenge.hashCode ^
        userName.hashCode ^
        photoUrl.hashCode ^
        gameWeekModel.hashCode ^
        lostAmountPerUnit.hashCode;
  }
}
