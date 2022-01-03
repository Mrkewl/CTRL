import 'dart:convert';

class CreateGame {
  CreateGame({
    this.roomName,
    this.commitmentPeriod,
    this.amount,
    this.roomLimit,
    this.gameCreatorEmail,
    this.startPeriod,
  });

  String? roomName;
  int? commitmentPeriod;
  int? amount;
  int? roomLimit;
  String? gameCreatorEmail;
  DateTime? startPeriod;

  DateTime get endPeriod =>
      startPeriod!.add(Duration(days: commitmentPeriod! * 7));

  CreateGame copyWith({
    String? roomName,
    int? commitmentPeriod,
    int? amount,
    int? roomLimit,
    String? gameCreatorEmail,
    DateTime? startPeriod,
  }) {
    return CreateGame(
      roomName: roomName ?? this.roomName,
      commitmentPeriod: commitmentPeriod ?? this.commitmentPeriod,
      amount: amount ?? this.amount,
      roomLimit: roomLimit ?? this.roomLimit,
      gameCreatorEmail: gameCreatorEmail ?? this.gameCreatorEmail,
      startPeriod: startPeriod ?? this.startPeriod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'commitmentPeriod': commitmentPeriod,
      'amount': amount,
      'roomLimit': roomLimit,
      'gameCreatorEmail': gameCreatorEmail,
      'startPeriod': startPeriod?.millisecondsSinceEpoch,
    };
  }

  // ignore: sort_constructors_first
  factory CreateGame.fromMap(Map<String, dynamic> map) {
    return CreateGame(
      roomName: map['roomName'],
      commitmentPeriod: map['commitmentPeriod']?.toInt(),
      amount: map['amount']?.toInt(),
      roomLimit: map['roomLimit']?.toInt(),
      gameCreatorEmail: map['gameCreatorEmail'],
      startPeriod: map['startPeriod'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startPeriod'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // ignore: sort_constructors_first
  factory CreateGame.fromJson(String source) =>
      CreateGame.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateGame(roomName: $roomName, commitmentPeriod: $commitmentPeriod, amount: $amount, roomLimit: $roomLimit, gameCreatorEmail: $gameCreatorEmail, startPeriod: $startPeriod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateGame &&
        other.roomName == roomName &&
        other.commitmentPeriod == commitmentPeriod &&
        other.amount == amount &&
        other.roomLimit == roomLimit &&
        other.gameCreatorEmail == gameCreatorEmail &&
        other.startPeriod == startPeriod;
  }

  @override
  int get hashCode {
    return roomName.hashCode ^
        commitmentPeriod.hashCode ^
        amount.hashCode ^
        roomLimit.hashCode ^
        gameCreatorEmail.hashCode ^
        startPeriod.hashCode;
  }
}
