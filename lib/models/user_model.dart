// ignore_for_file: sort_constructors_first

import 'dart:convert';

class UserModel {
  String email;

  String firstName;
  String lastName;
  String userName;
  String gender;
  String dateOfBirth;
  String country;
  String photoUrl;
  String dateCreated;
  bool registrationInformation;
  String missionStatement;
  String avatarImage;
  int totalCompletedWorkout;
  double walletAmount;
  int totalGamesParticipated;
  int totalMissedWorkout;
  double totalEarnings;
  int totalGamesParticipating;
  double totalAmountLost;
  double totalAmountTopUp;


  double get successRate =>
      totalCompletedWorkout/ (totalCompletedWorkout+ totalMissedWorkout);
  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.gender,
    required this.dateOfBirth,
    required this.country,
    required this.photoUrl,
    required this.dateCreated,
    required this.registrationInformation,
    required this.missionStatement,
    required this.avatarImage,
    required this.totalCompletedWorkout,
    required this.walletAmount,
    required this.totalGamesParticipated,
    required this.totalMissedWorkout,
    required this.totalEarnings,
    required this.totalGamesParticipating,
    required this.totalAmountLost,
    required this.totalAmountTopUp,
  });

  @override
  String toString() {
    return 'UserModel(email: $email, firstName: $firstName, lastName: $lastName, userName: $userName, gender: $gender, dateOfBirth: $dateOfBirth, country: $country, photoUrl: $photoUrl, dateCreated: $dateCreated, registrationInformation: $registrationInformation, missionStatement: $missionStatement, avatarImage: $avatarImage, totalCompletedWorkout: $totalCompletedWorkout, walletAmount: $walletAmount, totalGamesParticipated: $totalGamesParticipated, totalMissedWorkout: $totalMissedWorkout, totalEarnings: $totalEarnings, totalGamesParticipating: $totalGamesParticipating, totalAmountLost: $totalAmountLost, totalAmountTopUp: $totalAmountTopUp)';
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? userName,
    String? gender,
    String? dateOfBirth,
    String? country,
    String? photoUrl,
    String? dateCreated,
    bool? registrationInformation,
    String? missionStatement,
    String? avatarImage,
    int? totalCompletedWorkout,
    double? walletAmount,
    int? totalGamesParticipated,
    int? totalMissedWorkout,
    double? totalEarnings,
    int? totalGamesParticipating,
    double? totalAmountLost,
    double? totalAmountTopUp,
  }) {
    return UserModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      photoUrl: photoUrl ?? this.photoUrl,
      dateCreated: dateCreated ?? this.dateCreated,
      registrationInformation: registrationInformation ?? this.registrationInformation,
      missionStatement: missionStatement ?? this.missionStatement,
      avatarImage: avatarImage ?? this.avatarImage,
      totalCompletedWorkout: totalCompletedWorkout ?? this.totalCompletedWorkout,
      walletAmount: walletAmount ?? this.walletAmount,
      totalGamesParticipated: totalGamesParticipated ?? this.totalGamesParticipated,
      totalMissedWorkout: totalMissedWorkout ?? this.totalMissedWorkout,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      totalGamesParticipating: totalGamesParticipating ?? this.totalGamesParticipating,
      totalAmountLost: totalAmountLost ?? this.totalAmountLost,
      totalAmountTopUp: totalAmountTopUp ?? this.totalAmountTopUp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'country': country,
      'photoUrl': photoUrl,
      'dateCreated': dateCreated,
      'registrationInformation': registrationInformation,
      'missionStatement': missionStatement,
      'avatarImage': avatarImage,
      'totalCompletedWorkout': totalCompletedWorkout,
      'walletAmount': walletAmount,
      'totalGamesParticipated': totalGamesParticipated,
      'totalMissedWorkout': totalMissedWorkout,
      'totalEarnings': totalEarnings,
      'totalGamesParticipating': totalGamesParticipating,
      'totalAmountLost': totalAmountLost,
      'totalAmountTopUp': totalAmountTopUp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      userName: map['userName'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      country: map['country'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      dateCreated: map['dateCreated'] ?? '',
      registrationInformation: map['registrationInformation'] ?? false,
      missionStatement: map['missionStatement'] ?? '',
      avatarImage: map['avatarImage'] ?? '',
      totalCompletedWorkout: map['totalCompletedWorkout'] ?? 0,
      walletAmount: map['walletAmount'].toDouble() ?? 0,
      totalGamesParticipated: map['totalGamesParticipated'] ?? 0,
      totalMissedWorkout: map['totalMissedWorkout'] ?? 0,
      totalEarnings: map['totalEarnings'] ?? 0.0,
      totalGamesParticipating: map['totalGamesParticipating']?? 0,
      totalAmountLost: map['totalAmountLost'] ?? 0.0,
      totalAmountTopUp:  map['totalAmountTopUp'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.email == email &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.userName == userName &&
      other.gender == gender &&
      other.dateOfBirth == dateOfBirth &&
      other.country == country &&
      other.photoUrl == photoUrl &&
      other.dateCreated == dateCreated &&
      other.registrationInformation == registrationInformation &&
      other.missionStatement == missionStatement &&
      other.avatarImage == avatarImage &&
      other.totalCompletedWorkout == totalCompletedWorkout &&
      other.walletAmount == walletAmount &&
      other.totalGamesParticipated == totalGamesParticipated &&
      other.totalMissedWorkout == totalMissedWorkout &&
      other.totalEarnings == totalEarnings &&
      other.totalGamesParticipating == totalGamesParticipating &&
      other.totalAmountLost == totalAmountLost &&
      other.totalAmountTopUp == totalAmountTopUp;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      userName.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode ^
      country.hashCode ^
      photoUrl.hashCode ^
      dateCreated.hashCode ^
      registrationInformation.hashCode ^
      missionStatement.hashCode ^
      avatarImage.hashCode ^
      totalCompletedWorkout.hashCode ^
      walletAmount.hashCode ^
      totalGamesParticipated.hashCode ^
      totalMissedWorkout.hashCode ^
      totalEarnings.hashCode ^
      totalGamesParticipating.hashCode ^
      totalAmountLost.hashCode ^
      totalAmountTopUp.hashCode;
  }
}
