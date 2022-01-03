
import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class AppleChip extends StatelessWidget {
  const AppleChip({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 6, right: 6),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.8,
          height: MediaQuery.of(context).size.height / 16,
          decoration: const BoxDecoration(
            color: ColorPalette.black,
            borderRadius: BorderRadius.all(Radius.circular(360)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.8,
              height: MediaQuery.of(context).size.height / 18,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    const BorderRadius.all(Radius.circular(360)),
                // border: Border.all(
                //   width: 1.5,
                //   color: Colors.white.withOpacity(0.2),
                // ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/logo/apple-24.png',
                    scale: 1.4,
                  ),
                  const Text(
                    'Apple',
                    style: TextStyle(
                        color: ColorPalette.snow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 8,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
