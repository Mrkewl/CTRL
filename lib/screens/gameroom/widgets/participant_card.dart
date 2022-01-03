import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:flutter/material.dart';

class ParticipantCard extends StatelessWidget {
   ParticipantCard(
      {Key? key,
      this.avatarImage = 'https://www.w3schools.com/howto/img_avatar.png',
      required this.name,
      required this.missedWorkout,
      required this.totalAmount,
      required this.earned,
      required this.commitment})
      : super(key: key);
  final String avatarImage;
  final String name;
  final String missedWorkout;
  final String totalAmount;
  final String earned;
  final String commitment;
    final GameRoomController gameController = GameRoomController.to;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
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
              height: 100,
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(avatarImage),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                  color: ColorPalette.snow, fontSize: 14),
                            ),
                            // if(!gameController.gameStart.value)
                            // ...[Text(
                            //   'Missed: $missedWorkout',
                            //   style: const TextStyle(
                            //       color: ColorPalette.snow, fontSize: 14),
                            // ),
                            // Text(
                            //   'Total Amount Earned: $earned',
                            //   style: const TextStyle(
                            //       color: ColorPalette.snow, fontSize: 14),
                            // ),] else 
                            // ...[
                            //   Row(
                            //     children:const [
                            //   Text('Ready'),
                            //   Icon(Icons.lightbulb)
                            //     ],
                            //   )
                            // ]
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Commitment:\n $commitment / Week',
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                              color: ColorPalette.snow, fontSize: 14),
                        ),
                      ),
                    ),
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
