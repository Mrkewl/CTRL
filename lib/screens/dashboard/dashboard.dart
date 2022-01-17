import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/screens/dashboard/widgets/informationbox_totalearning.dart';
import 'package:ctrl_app/screens/dashboard/widgets/informationbox_totalgamesparticipating.dart';
import 'package:ctrl_app/screens/dashboard/widgets/informationbox_wallet.dart';
import 'package:ctrl_app/screens/dashboard/widgets/informationbox_workout.dart';
import 'package:ctrl_app/screens/dashboard/widgets/name_avatarsection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/informationbox_percentageearnedwidget.dart';
import 'widgets/informationbox_successrate.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final HomeController dashboardController = HomeController.to;
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              NameAvatarSection(
                name: authenticationController.user.value.userName,
                photoUrl: authenticationController.profilePicture,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Obx(
                          () => InformationBoxWorkoutCompleted(
                            graph: false,
                            header: 'Total Completed Workouts',
                            long: false,
                            totalCompletedWorkout: authenticationController
                                .user.value.totalCompletedWorkout,
                          ),
                        ),
                      ),
                      InformationBoxSuccessRate(
                        graph: false,
                        header: 'Success Rate',
                        long: false,
                        successRate:
                            authenticationController.user.value.successRate,
                      ),
                      InformationBoxWallet(
                        graph: false,
                        header: 'Wallet',
                        long: false,
                        walletAmount:
                            authenticationController.user.value.walletAmount,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const InformationBoxPercentageEarned(
                        graph: true,
                        header: 'Earning%/Week',
                        long: true,
                      ),
                      InformationBoxTotalEarnings(
                        graph: false,
                        header: 'Total Earnings',
                        long: false,
                        totalEarnings:
                            authenticationController.user.value.totalEarnings,
                      ),
                      InformationBoxTotalGamesParticipating(
                          graph: false,
                          header: 'Total Games Participating',
                          long: false,
                          totalGamesParticipating: authenticationController
                              .user.value.totalGamesParticipating),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
