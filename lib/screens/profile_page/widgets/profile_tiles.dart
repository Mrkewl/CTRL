import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class ProfileTiles extends StatelessWidget {
  const ProfileTiles({
    Key? key,
    required this.header,
  }) : super(key: key);
  final String header;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 16,
          decoration: BoxDecoration(
            color: ColorPalette.primaryPurple,
            boxShadow: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.2),
                offset: const Offset(0, 4),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(360)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(360)),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      header,
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 16),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: ColorPalette.snow,
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                )),
          ),
        ),
      ),
    ]);
  }
}
