import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class InformationBoxTotalGamesParticipating extends StatelessWidget {
  const InformationBoxTotalGamesParticipating({
    Key? key,
    required this.long,
    required this.header,
    required this.graph,
    required this.totalGamesParticipating,
  }) : super(key: key);
  final bool long;
  final String header;
  final bool graph;
  final int totalGamesParticipating;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: long ? 300 : 150,
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
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 2.4,
              height: long ? 300 : 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
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
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    totalGamesParticipating.toString(),
                    style:
                        const TextStyle(color: ColorPalette.snow, fontSize: 34),
                  )),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Total Games Participating',
                          style:
                              TextStyle(color: ColorPalette.snow, fontSize: 14),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
