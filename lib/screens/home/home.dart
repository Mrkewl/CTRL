import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/screens/dashboard/dashboard.dart';
import 'package:ctrl_app/screens/registration/register_information_page.dart';
import 'package:ctrl_app/screens/search/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final HomeController dashboardController = HomeController.to;
  final List<Widget> pages = [
    Dashboard(),
     SearchPage(),
    RegisterInformation(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// TODO the pop scopeewdds
        final timeBackPressed = DateTime.now();
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        if (isExitWarning) {
          const message = 'Press back again to exit';
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(message)));
          return false;
        } else {
          ScaffoldMessenger.of(context).clearSnackBars();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundDarkPurple,
        body: Obx(
          () => IndexedStack(
            index: dashboardController.pageSelected.value,
            children: pages,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (item) {
              dashboardController.pageSelected.value = item;
            },
            backgroundColor: ColorPalette.black,
            unselectedItemColor: ColorPalette.snow,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 2,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: dashboardController.pageSelected.value == 0
                        ? ColorPalette.brightGreen
                        : ColorPalette.snow,
                  ),
                  label: 'Personal'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: dashboardController.pageSelected.value == 1
                        ? ColorPalette.brightGreen
                        : ColorPalette.snow,
                  ),
                  label: 'Personal'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.directions_run,
                    color: dashboardController.pageSelected.value == 2
                        ? ColorPalette.brightGreen
                        : ColorPalette.snow,
                  ),
                  label: 'Personal'),
            ],
          ),
        ),
      ),
    );
  }
}
