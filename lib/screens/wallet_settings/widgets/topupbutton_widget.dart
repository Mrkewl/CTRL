
import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:flutter/material.dart';

class TopUpButton extends StatelessWidget {
  TopUpButton({
    Key? key,
    required this.amount,
    required this.buttonColor,
  }) : super(key: key);
  final double amount;
  final Color buttonColor;

  final AuthenticationController authenticationController =
      AuthenticationController.to;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final bool? userDecision = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    contentPadding: EdgeInsets.zero,
                    content: Container(
                      decoration: BoxDecoration(
                          color: ColorPalette.darkGrey,
                          borderRadius: BorderRadius.circular(20.0)),
                      height: 200,
                      width: 200,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Are you sure you like to top up \$$amount to your current balance?',
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 20),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(100, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ColorPalette.primaryPurple)),
                                    child: const Text(
                                      'Proceed',
                                      style: TextStyle(
                                          color: ColorPalette.snow,
                                          fontSize: 16),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(100, 50)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ColorPalette.primaryPurple)),
                                    child: const Text(
                                      'No',
                                      style: TextStyle(
                                          color: ColorPalette.snow,
                                          fontSize: 16),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
          if (userDecision == true) {
            authenticationController.topUp(amount);
          }
        },
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(100, 50)),
            backgroundColor: MaterialStateProperty.all(buttonColor)),
        child: Text(
          '\$$amount',
          style:  TextStyle(
              color: buttonColor == ColorPalette.black
                  ? ColorPalette.snow
                  : ColorPalette.black,
              fontSize: 16),
        ));
  }
}
