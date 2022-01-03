import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/models/participant_model.dart';
import 'package:flutter/material.dart';

class GameRoomWidget extends StatelessWidget {
  const GameRoomWidget({
    Key? key,
    required this.commitmentPeriod,
    required this.id,
    required this.participants,
    required this.potAmount,
    required this.buyInAmount,
    required this.started,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.gameCreatorEmail,
  }) : super(key: key);
  final String name;
  final String id;
  final List<ParticipantModel> participants;
  final double potAmount;
  final double buyInAmount;
  final bool started;
  final String startDate;
  final String endDate;
  final int commitmentPeriod;
  final String gameCreatorEmail;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 150,
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
              width: MediaQuery.of(context).size.width,
              height: 150,
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 24),
                    ),
                    Text(
                      '$commitmentPeriod Weeks',
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 18),
                    ),
                    Text(
                      '\$$buyInAmount Buy in',
                      style: const TextStyle(
                          color: ColorPalette.snow, fontSize: 18),
                    ),
                    Text(
                      gameCreatorEmail,
                      style: const TextStyle(
                          color: ColorPalette.brightGreen, fontSize: 14),
                    ),
                    const Spacer(),
                    Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                              height: 24, width: 24, child: CircleAvatar()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                              height: 24, width: 24, child: CircleAvatar()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                              height: 24, width: 24, child: CircleAvatar()),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                              height: 24, width: 24, child: CircleAvatar()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
