// ignore_for_file: sort_constructors_first

import 'dart:convert';

class WorkoutDayModel {
  String dateWorkedOut;
  WorkoutDayModel({
    required this.dateWorkedOut,
  });

  WorkoutDayModel copyWith({
    String? dateWorkedOut,
  }) {
    return WorkoutDayModel(
      dateWorkedOut: dateWorkedOut ?? this.dateWorkedOut,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateWorkedOut': dateWorkedOut,
    };
  }

  factory WorkoutDayModel.fromMap(Map<String, dynamic> map) {
    return WorkoutDayModel(
      dateWorkedOut: map['dateWorkedOut'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutDayModel.fromJson(String source) => WorkoutDayModel.fromMap(json.decode(source));

  @override
  String toString() => 'WorkoutDayModel(dateWorkedOut: $dateWorkedOut)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WorkoutDayModel &&
      other.dateWorkedOut == dateWorkedOut;
  }

  @override
  int get hashCode => dateWorkedOut.hashCode;
}
