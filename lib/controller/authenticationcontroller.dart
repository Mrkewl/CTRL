import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';

import 'package:ctrl_app/common/helper/helper.dart';
import 'package:ctrl_app/models/gameroom_model.dart';
import 'package:ctrl_app/models/gameweek_model.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:ctrl_app/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

enum googleSignupResults { register, signIn, failed }

class AuthenticationController extends GetxController {
  static AuthenticationController get to => Get.find();
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString userName = ''.obs;
  RxString gender = 'Nil'.obs;
  RxString dateOfBirth = ''.obs;
  RxString country = ''.obs;
  RxString confirmPassword = ''.obs;
  RxString photoUrl = ''.obs;
  RxString dateCreated = ''.obs;
  RxBool registrationInformation = false.obs;
  RxBool loadingIndicator = false.obs;
  RxString missionStatement = ''.obs;

  RxString avatarImage = ''.obs;
  Rx<UserModel> user = UserModel(
          totalAmountLost: 0,
          totalAmountTopUp: 0,
          email: '',
          firstName: '',
          lastName: '',
          userName: '',
          gender: '',
          dateOfBirth: '',
          country: '',
          photoUrl: '',
          dateCreated: '',
          registrationInformation: false,
          missionStatement: '',
          avatarImage: '',
          totalCompletedWorkout: 0,
          walletAmount: 0,
          totalGamesParticipated: 0,
          totalMissedWorkout: 0,
          totalEarnings: 0,
          totalGamesParticipating: 0)
      .obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference usersData =
      FirebaseFirestore.instance.collection('users');
  Future<void> registerUser() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.value, password: password.value);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> validationCheckRegistration(BuildContext context) async {
    if (password.value.length >= 6 &&
        confirmPassword.value.length >= 6 &&
        password.value == confirmPassword.value &&
        email.contains('@') &&
        email.contains('.') &&
        email.isNotEmpty) {
      try {
        await registerUser();
        //Create user data when register
        await usersData
            .doc(email.value.toLowerCase())
            .set({'email': email.value, 'registrationInformation': false});
        user.value.photoUrl = 'https://www.w3schools.com/howto/img_avatar.png';
        return true;
      } catch (e) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('There is some error'),
      ));
      return false;
    }
  }

  Future<bool> validationCheckUserInformationAndStore(
      BuildContext context) async {
    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        gender.isNotEmpty &&
        dateOfBirth.isNotEmpty) {
      try {
        final UserModel registeringUser = UserModel(
          totalAmountLost: 0,
          totalAmountTopUp: 0,
          avatarImage: avatarImage.value.isEmpty ? '' : avatarImage.value,
          country: country.value,
          walletAmount: 0,
          dateCreated: DateTime.now().toIso8601String(),
          dateOfBirth: dateOfBirth.value,
          email: email.value.isEmpty
              ? FirebaseAuth.instance.currentUser!.email!
              : email.value,
          firstName: firstName.value,
          userName: userName.value,
          gender: gender.value,
          lastName: lastName.value,
          missionStatement: 'Investing In My Fitness',
          photoUrl: user.value.photoUrl.isEmpty
              ? FirebaseAuth.instance.currentUser!.photoURL!
              : user.value.photoUrl,
          registrationInformation: true,
          totalCompletedWorkout: 0,
          totalMissedWorkout: 0,
          totalEarnings: 0,
          totalGamesParticipating: 0,
          totalGamesParticipated: 0,
        );
        //Create user data when register
        await usersData
            .doc(FirebaseAuth.instance.currentUser!.email)
            .set(registeringUser.toMap(), SetOptions(merge: true));
        dateCreated.value = DateFormat("dd MMM yyyy").format(DateTime.now());
        await getUserInfo();
        return true;
      } catch (e) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('There is some error'),
      ));

      return false;
    }
  }

  Future<bool> signInWithEmail(BuildContext context) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await auth.signInWithEmailAndPassword(
            email: email.value, password: password.value);
        //Create user last sign in data
        await usersData.doc(FirebaseAuth.instance.currentUser!.email).update({
          'last_sign_in': DateTime.now().toIso8601String(),
        });
        await getUserInfo();
        return true;
      } on FirebaseAuthException catch (e) {
        log(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        return false;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('There is some error'),
      ));

      return false;
    }
  }

  Future<googleSignupResults> signInSignUpWithGoogle(
      BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final DocumentSnapshot results =
          await usersData.doc(googleUser!.email).get();
      if (results.exists) {
        await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
          'email': FirebaseAuth.instance.currentUser!.email,
          // 'userName': FirebaseAuth.instance.currentUser!.email,
          'last_sign_in': DateTime.now().toIso8601String(),
        }, SetOptions(merge: true));
        photoUrl.value = FirebaseAuth.instance.currentUser!.photoURL!;
        await getUserInfo();
        return googleSignupResults.signIn;
      } else {
        await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
          'email': FirebaseAuth.instance.currentUser!.email,
          'userName': FirebaseAuth.instance.currentUser!.email,
          'last_sign_in': DateTime.now().toIso8601String(),
          'registrationInformation': false
        }, SetOptions(merge: true));
        if (avatarImage.isEmpty) {
          photoUrl.value = FirebaseAuth.instance.currentUser!.photoURL!;
        }
        return googleSignupResults.register;
      }
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return googleSignupResults.failed;
    }
  }

  Future<void> getUserInfo() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        final User? firebaseUser = FirebaseAuth.instance.currentUser;
        if (FirebaseAuth.instance.currentUser!.photoURL != null &&
            avatarImage.value.isEmpty) {
          user.value.photoUrl = FirebaseAuth.instance.currentUser!.photoURL!;
        } else {
          user.value.photoUrl =
              'https://www.w3schools.com/howto/img_avatar.png';
        }

        // dateCreated.value =
        //     DateFormat("dd MMM yyyy").format(user!.metadata.creationTime!);

        email.value = firebaseUser!.email!;
        await usersData
            .doc(FirebaseAuth.instance.currentUser!.email)
            .get()
            .then((DocumentSnapshot documentSnapshot) => registrationInformation
                .value = documentSnapshot['registrationInformation']);
        if (registrationInformation.value == false) {
          return;
        } else {
          await usersData
              .doc(FirebaseAuth.instance.currentUser!.email)
              .get()
              .then((DocumentSnapshot documentSnapshot) => {
                    log(documentSnapshot.data().toString()),
                    user = UserModel.fromMap(
                            documentSnapshot.data()! as Map<String, dynamic>)
                        .obs
                  });
          log(user.value.toString());
        }

        await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
          'last_sign_in': DateTime.now().toIso8601String(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> setUpAuthController(List<GameRoomModel> gameRooms) async {
    if (user.value.email.isNotEmpty) {
      user.value.totalCompletedWorkout = totalCompletedWorkout(gameRooms);
      user.value.totalEarnings = totalEarnings(gameRooms);
      user.value.totalGamesParticipated = totalGamesParticipated(gameRooms);
      user.value.totalGamesParticipating = totalGamesParticipating(gameRooms);
      user.value.totalMissedWorkout = totalMissedWorkout(gameRooms);
      user.value.walletAmount = amountHolding(gameRooms);
      user.value.totalAmountLost = totalAmountLoss(gameRooms);
      updateDocument();
    }
  }

  Future<void> updateDocument() async {
    await usersData
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update(user.value.toMap());
  }

  ///TODO The commitment per week did not get set up

  Future<void> changeMissionStatement() async {
    try {
      await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
        'mission_statement': missionStatement.value,
      }, SetOptions(merge: true));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> topUp(double topUp) async {
    try {
      log(user.value.walletAmount.toString());
      user.value.totalAmountTopUp = user.value.totalAmountTopUp + topUp;
      user.value.walletAmount = user.value.totalAmountTopUp +
          user.value.totalEarnings -
          user.value.totalAmountLost;
      await usersData.doc(FirebaseAuth.instance.currentUser!.email).update({
        'totalAmountTopUp': user.value.totalAmountTopUp,
        'walletAmount' : user.value.walletAmount
      });
      user.refresh();
    } catch (e) {
      log(e.toString());
    }
  }

  Future uploadImageToFirebase() async {
    final File? _imageFile = await Helper().pickImage();
    if (_imageFile == null) {
      return;
    } else {
      final String fileName = basename(_imageFile.path);
      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      final UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      await uploadTask.then((res) async {
        user.value.avatarImage = await res.ref.getDownloadURL();
      });
    }
    updateDocument();
  }

  String basename(String path) {
    return 'avatarname_$path';
  }

  String get profilePicture {
    if (user.value.avatarImage.isEmpty) {
      return user.value.photoUrl;
    } else {
      return user.value.avatarImage;
    }
  }

  int totalCompletedWorkout(List<GameRoomModel> gameRooms) {
    int totalGamesCompletedWorkout = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      final ParticipantModel? currentUser = gameRoom.participants!
          .firstWhereOrNull((element) => element.email == user.value.email);
      if (currentUser == null) {
        return 0;
      } else {
        for (final GameWeekModel gameWeek in currentUser.gameWeekModel) {
          totalGamesCompletedWorkout =
              totalGamesCompletedWorkout + gameWeek.workoutDays.length;
        }
      }
    }
    return totalGamesCompletedWorkout;
  }

  double totalEarnings(List<GameRoomModel> gameRooms) {
    double totalGamesEarnings = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      final ParticipantModel? currentUser = gameRoom.participants!
          .firstWhereOrNull((element) => element.email == user.value.email);
      if (currentUser == null) {
        return 0;
      } else {
        for (final GameWeekModel gameWeek in currentUser.gameWeekModel) {
          totalGamesEarnings = totalGamesEarnings + gameWeek.earnedThisweek;
        }
      }
    }
    return totalGamesEarnings;
  }

  int totalGamesParticipated(List<GameRoomModel> gameRooms) {
    int totalGamesUserParticipated = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      for (final ParticipantModel participant in gameRoom.participants!) {
        if (participant.email == user.value.email) {
          totalGamesUserParticipated++;
        }
      }
    }
    return totalGamesUserParticipated;
  }

  int totalGamesParticipating(List<GameRoomModel> gameRooms) {
    int totalGamesUserParticipating = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      if (DateFormat("dd-MM-yyyy")
          .parse(gameRoom.endDate!)
          .isAfter(DateTime.now())) {
        for (final ParticipantModel participant in gameRoom.participants!) {
          if (participant.email == user.value.email) {
            totalGamesUserParticipating++;
          }
        }
      }
    }
    return totalGamesUserParticipating;
  }

  int totalMissedWorkout(List<GameRoomModel> gameRooms) {
    int totalMissedWorkoutsInGame = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      final ParticipantModel? currentUser = gameRoom.participants!
          .firstWhereOrNull((element) => element.email == user.value.email);
      if (currentUser == null) {
        return 0;
      } else {
        for (final GameWeekModel gameWeek in currentUser.gameWeekModel) {
          totalMissedWorkoutsInGame =
              totalMissedWorkoutsInGame + gameWeek.missedWorkoutThisWeek;
        }
      }
    }
    return totalMissedWorkoutsInGame;
  }

  double deductWalletAmout(double entryFee) {
    return user.value.walletAmount = user.value.walletAmount - entryFee;
  }

  double amountHolding(List<GameRoomModel> gameRooms) {
    return user.value.walletAmount +
        user.value.totalEarnings -
        totalAmountLoss(gameRooms);
  }

  double totalAmountLoss(List<GameRoomModel> gameRooms) {
    double totalAmountLoss = 0;
    for (final GameRoomModel gameRoom in gameRooms) {
      final ParticipantModel? currentUser = gameRoom.participants!
          .firstWhereOrNull((element) => element.email == user.value.email);
      if (currentUser == null) {
        return 0;
      } else {
        totalAmountLoss = totalAmountLoss + currentUser.currentAmountLost!;
      }
    }
    return totalAmountLoss;
  }
}


//post_install do |installer|
//   installer.pods_project.targets.each do |target|
//     flutter_additional_ios_build_settings(target)
//     target.build_configurations.each do |config|
//       config.build_settings['ENABLE_BITCODE'] = 'NO'
//       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
//     end
//   end
// end