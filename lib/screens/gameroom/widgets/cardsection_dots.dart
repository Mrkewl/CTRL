import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardSectionDots extends StatelessWidget {
  CardSectionDots({this.dotNumber});
  int? dotNumber = 0;

  @override
  Widget build(BuildContext context) {
    Color dotcolour1(int selectedDotColor) {
      Color color;
      if (selectedDotColor == 0) {
     color = ColorPalette.brightGreen;
      } else {
        color = Colors.grey;
      }
      return color;
    }

    Color dotcolour2(int selectedDotColor) {
      Color color;
      if (selectedDotColor == 1) {
        color = ColorPalette.brightGreen;
      } else {
        color = Colors.grey;
      }
      return color;
    }

    Color dotcolour3(int selectedDotColor) {
      Color color;
      if (selectedDotColor == 2) {
        color = ColorPalette.brightGreen;
      } else {
        color = Colors.grey;
      }
      return color;
    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 10,
            width: dotNumber == 0? 30: 10,
            decoration: BoxDecoration(
                color: dotcolour1(dotNumber!),
                borderRadius: BorderRadius.circular(360)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 10,
            width: dotNumber == 1? 30: 10,
            decoration: BoxDecoration(
                color: dotcolour2(dotNumber!),
                borderRadius: BorderRadius.circular(360)),
          ),
        ),
                Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 10,
            width: dotNumber == 2? 30: 10,
            decoration: BoxDecoration(
                color: dotcolour3(dotNumber!),
                borderRadius: BorderRadius.circular(360)),
          ),
        ),
      ],
    );
  }
}
