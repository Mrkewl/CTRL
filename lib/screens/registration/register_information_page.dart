import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/common/widgets/landingpage_button_widget.dart';
import 'package:ctrl_app/common/widgets/registrationtextfield_widget.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'widgets/avatar_widget_field.dart';

class RegisterInformation extends StatelessWidget {
  RegisterInformation({Key? key}) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  final GameRoomController gameRoomController = GameRoomController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backgroundDarkPurple,
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Register',
                        style:
                            TextStyle(color: ColorPalette.snow, fontSize: 28),
                      ),
                    ),
                    RegistrationSignInTextField(
                      birthday: false,
                      gender: false,
                      header: 'Username',
                      fields: authenticationController.userName,
                    ),
                    RegistrationSignInTextField(
                      birthday: false,
                      gender: false,
                      header: 'First Name',
                      fields: authenticationController.firstName,
                    ),
                    //DEbug token 31AB2481-0DF8-48DF-A8E1-1D5A777C28AC
                    RegistrationSignInTextField(
                      birthday: false,
                      fields: authenticationController.lastName,
                      gender: false,
                      header: 'Last Name',
                    ),
                    RegistrationSignInTextField(
                      birthday: false,
                      gender: true,
                      fields: authenticationController.gender,
                      header: 'Gender',
                    ),
                    RegistrationSignInTextField(
                      gender: false,
                      birthday: true,
                      fields: authenticationController.dateOfBirth,
                      header: 'Date Of Birth',
                    ),
                    GestureDetector(
                        onTap: () async {
                          authenticationController
                              .loadingIndicatorForProfileUpload.value = true;
                          await authenticationController
                              .uploadImageToFirebase();
                                authenticationController
                              .loadingIndicatorForProfileUpload.value = false;
                        },
                        child:
                             AvatarFieldWidget()),
                    const Spacer(),
                    Center(
                      child: GestureDetector(
                          onTap: () async {
                            authenticationController
                                .loadingIndicatorForRegistrationLogin.value = true;
                            if (DateTime.now().year -
                                    DateFormat('dd-MM-yyyy')
                                        .parse(authenticationController
                                            .dateOfBirth.value)
                                        .year <
                                18) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('You have to be older than 18'),
                              ));
                            } else if (await authenticationController
                                .validationCheckUserInformationAndStore(
                                    context)) {
                              await gameRoomController.controllerSetUp(
                                  authenticationController.user.value);
                              authenticationController
                                  .loadingIndicatorForRegistrationLogin
                                  .value = false;

                              Get.to(Home());
                            }
                            authenticationController
                                .loadingIndicatorForRegistrationLogin.value = false;
                          },
                          child: PurpleMainButtonWidget(text: 'Register')),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
