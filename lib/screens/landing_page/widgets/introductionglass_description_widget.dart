import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class IntroductionGlassDescription extends StatelessWidget {
  const IntroductionGlassDescription({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height / 13,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: ColorPalette.neonGreen, fontSize: 20),
      )),
    );
  }
}