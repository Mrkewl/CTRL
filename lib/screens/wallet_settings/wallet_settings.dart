import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/topupbutton_widget.dart';

class WalletSettingsScreen extends StatelessWidget {
  WalletSettingsScreen({Key? key}) : super(key: key);
  final AuthenticationController authenticationController =
      AuthenticationController.to;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundDarkPurple,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: ColorPalette.snow,
                      size: 32,
                    ),
                  ),
                  const Center(
                    child: Text(
                      'Wallet Settings',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 22),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Current Balance',
                  style: TextStyle(
                      color: ColorPalette.snow.withOpacity(0.50), fontSize: 32),
                )),
            //This changes the balance
            Obx(
              () => Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: Text(
                    authenticationController.currentBalance.value.isEmpty
                        ? '\$' '0'
                        : '\$${authenticationController.currentBalance.value}',
                    style:
                        const TextStyle(color: ColorPalette.snow, fontSize: 40),
                  )),
            ),
            const Divider(
              color: ColorPalette.snow,
              height: 2,
              thickness: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
                child: Text(
                  'Top Up',
                  style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TopUpButton(
                  amount: 100,
                  buttonColor: ColorPalette.black,
                ),
                TopUpButton(
                  amount: 200,
                  buttonColor: ColorPalette.primaryPurple,
                ),
                TopUpButton(
                  amount: 500,
                  buttonColor: ColorPalette.brightGreen,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
