// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:ctrl_app/models/workoutday_model.dart';
import 'package:flutter/foundation.dart';

class GameWeekModel {
  String startDate;
  String endDate;
  int completedWorkoutThisWeek;
  int missedWorkoutThisWeek;
  double earnedThisweek;
  double lostThisWeek;
  List<WorkoutDayModel> workoutDays; 
  GameWeekModel({
    required this.startDate,
    required this.endDate,
    required this.completedWorkoutThisWeek,
    required this.missedWorkoutThisWeek,
    required this.earnedThisweek,
    required this.lostThisWeek,
    required this.workoutDays,
  });

  GameWeekModel copyWith({
    String? startDate,
    String? endDate,
    int? completedWorkoutThisWeek,
    int? missedWorkoutThisWeek,
    double? earnedThisweek,
    double? lostThisWeek,
    List<WorkoutDayModel>? workoutDays,
  }) {
    return GameWeekModel(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completedWorkoutThisWeek: completedWorkoutThisWeek ?? this.completedWorkoutThisWeek,
      missedWorkoutThisWeek: missedWorkoutThisWeek ?? this.missedWorkoutThisWeek,
      earnedThisweek: earnedThisweek ?? this.earnedThisweek,
      lostThisWeek: lostThisWeek ?? this.lostThisWeek,
      workoutDays: workoutDays ?? this.workoutDays,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'completedWorkoutThisWeek': completedWorkoutThisWeek,
      'missedWorkoutThisWeek': missedWorkoutThisWeek,
      'earnedThisweek': earnedThisweek,
      'lostThisWeek': lostThisWeek,
      'workoutDays': workoutDays.map((x) => x.toMap()).toList(),
    };
  }

  factory GameWeekModel.fromMap(Map<String, dynamic> map) {
    return GameWeekModel(
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      completedWorkoutThisWeek: map['completedWorkoutThisWeek']?.toInt() ?? 0,
      missedWorkoutThisWeek: map['missedWorkoutThisWeek']?.toInt() ?? 0,
      earnedThisweek: map['earnedThisweek']?.toDouble() ?? 0.0,
      lostThisWeek: map['lostThisWeek']?.toDouble() ?? 0.0,
      workoutDays: List<WorkoutDayModel>.from(map['workoutDays']?.map((x) => WorkoutDayModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameWeekModel.fromJson(String source) => GameWeekModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GameWeekModel(startDate: $startDate, endDate: $endDate, completedWorkoutThisWeek: $completedWorkoutThisWeek, missedWorkoutThisWeek: $missedWorkoutThisWeek, earnedThisweek: $earnedThisweek, lostThisWeek: $lostThisWeek, workoutDays: $workoutDays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is GameWeekModel &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.completedWorkoutThisWeek == completedWorkoutThisWeek &&
      other.missedWorkoutThisWeek == missedWorkoutThisWeek &&
      other.earnedThisweek == earnedThisweek &&
      other.lostThisWeek == lostThisWeek &&
      listEquals(other.workoutDays, workoutDays);
  }

  @override
  int get hashCode {
    return startDate.hashCode ^
      endDate.hashCode ^
      completedWorkoutThisWeek.hashCode ^
      missedWorkoutThisWeek.hashCode ^
      earnedThisweek.hashCode ^
      lostThisWeek.hashCode ^
      workoutDays.hashCode;
  }
}
