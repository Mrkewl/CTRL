import 'dart:convert';

import 'package:ctrl_app/models/participant_model.dart';
import 'package:flutter/foundation.dart';

class GameRoomModel {
  // ignore: sort_constructors_first
  GameRoomModel(
      {required this.name,
      required this.id,
      required this.participants,
      required this.potAmount,
      required this.buyInAmount,
      required this.started,
      required this.startDate,
      required this.endDate,
      required this.commitmentPeriod,
      required this.gameCreatorEmail,
      required this.roomLimit,
      this.documentId,
      required this.ctrlEarnings,
      required this.ended});
  String? name;
  String? id;
  List<ParticipantModel>? participants;
  double? potAmount;
  double? buyInAmount;
  bool? started;
  String? startDate;
  String? endDate;
  String? gameCreatorEmail;
  int? roomLimit;
  String? documentId;
  int? commitmentPeriod;
  double? ctrlEarnings;
  bool? ended;

  GameRoomModel copyWith({
    String? name,
    String? id,
    List<ParticipantModel>? participants,
    double? potAmount,
    double? buyInAmount,
    bool? started,
    String? startDate,
    String? endDate,
    String? gameCreatorEmail,
    int? roomLimit,
    int? commitmentPeriod,
    String? documentId,
    double? ctrlEarnings,
    bool? ended,
  }) {
    return GameRoomModel(
        name: name ?? this.name,
        id: id ?? this.id,
        documentId: documentId ?? this.documentId,
        participants: participants ?? this.participants,
        potAmount: potAmount ?? this.potAmount,
        buyInAmount: buyInAmount ?? this.buyInAmount,
        started: started ?? this.started,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        gameCreatorEmail: gameCreatorEmail ?? this.gameCreatorEmail,
        roomLimit: roomLimit ?? this.roomLimit,
        commitmentPeriod: commitmentPeriod ?? this.commitmentPeriod,
        ctrlEarnings: ctrlEarnings ?? this.ctrlEarnings,
        ended: ended ?? this.ended);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'potAmount': potAmount,
      'buyInAmount': buyInAmount,
      'started': started,
      'startDate': startDate,
      'endDate': endDate,
      'commitmentPeriod': commitmentPeriod,
      'gameCreatorEmail': gameCreatorEmail,
      'roomLimit': roomLimit,
      'documentId': documentId,
      'participants': participants?.map((x) => x.toMap()).toList(),
      'ctrlEarnings': ctrlEarnings,
      'ended': ended,
    };
  }

  // ignore: sort_constructors_first
  factory GameRoomModel.fromMap(Map<String, dynamic> map) {
    return GameRoomModel(
        name: map['name'],
        id: map['id'],
        potAmount: map['potAmount']?.toDouble(),
        buyInAmount: map['buyInAmount']?.toDouble(),
        started: map['started'],
        startDate: map['startDate'] ?? '',
        endDate: map['endDate'] ?? '',
        commitmentPeriod: map['commitmentPeriod'] ?? 0,
        gameCreatorEmail: map['gameCreatorEmail'] ?? '',
        roomLimit: map['roomLimit'] ?? 0,
        documentId: map['documentId'] ?? '',
        ctrlEarnings: map['ctrlEarnings'] ?? 0.0,
        participants: map['participants'] != null
            ? List<ParticipantModel>.from(
                map['participants']?.map((x) => ParticipantModel.fromMap(x)))
            : null,
        ended: map['ended']);
  }

  String toJson() => json.encode(toMap());

  // ignore: sort_constructors_first
  factory GameRoomModel.fromJson(String source) =>
      GameRoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GameRoomModel(name: $name, id: $id, participants: $participants, potAmount: $potAmount, buyInAmount: $buyInAmount, started: $started, startDate: $startDate, endDate: $endDate, commitmentPeriod: $commitmentPeriod , gameCreatorEmail: $gameCreatorEmail , roomLimit: $roomLimit , documentId: $documentId, ctrlEarnings: $ctrlEarnings, ended: $ended)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GameRoomModel &&
        other.name == name &&
        other.id == id &&
        listEquals(other.participants, participants) &&
        other.potAmount == potAmount &&
        other.buyInAmount == buyInAmount &&
        other.started == started &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.documentId == documentId &&
        other.gameCreatorEmail == gameCreatorEmail &&
        other.roomLimit == roomLimit &&
        other.commitmentPeriod == commitmentPeriod &&
        other.ctrlEarnings == ctrlEarnings &&
        other.ended == ended;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        participants.hashCode ^
        potAmount.hashCode ^
        buyInAmount.hashCode ^
        documentId.hashCode ^
        started.hashCode ^
        startDate.hashCode ^
        commitmentPeriod.hashCode ^
        roomLimit.hashCode ^
        gameCreatorEmail.hashCode ^
        endDate.hashCode ^
        ctrlEarnings.hashCode ^
        ended.hashCode;
  }
}
