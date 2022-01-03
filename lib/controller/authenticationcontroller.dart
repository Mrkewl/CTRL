import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctrl_app/common/helper/helper.dart';
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
  RxString currentBalance = ''.obs;
  RxString avatarImage = ''.obs;
  Rx<UserModel> user = UserModel(
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
                    user = UserModel.fromMap(
                            documentSnapshot.data()! as Map<String, dynamic>)
                        .obs
                  });
          print(user.value);
        }

        await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
          'last_sign_in': DateTime.now().toIso8601String(),
        }, SetOptions(merge: true));
      }
    } catch (e) {
      log(e.toString());
    }
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

  Future<void> addBalance(double topUp) async {
    try {
      final double totalAmount = double.parse(
              currentBalance.value.isEmpty ? '0' : currentBalance.value) +
          topUp;
      currentBalance.value = totalAmount.toString();
      await usersData.doc(FirebaseAuth.instance.currentUser!.email).set({
        'wallet_balance': currentBalance.value,
      }, SetOptions(merge: true));
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
}