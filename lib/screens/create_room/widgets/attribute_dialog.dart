

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/creategame_model.dart';
import 'package:flutter/material.dart';

import 'dropdowntile.dart';

class AttributeDialog extends StatelessWidget {
  AttributeDialog({
    Key? key,
    required this.attribute,
    required this.roomLimit,
    required this.amount,
    required this.commitmentPeriod,
    required this.createGamevalues,
  }) : super(key: key);

  final createRoomAttribute attribute;
  final List<int> roomLimit;
  final List<int> amount;
  final List<int> commitmentPeriod;
  final GameRoomController gameRoomController = GameRoomController.to;
  final CreateGame createGamevalues;
  final TextEditingController groupname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorPalette.black,
          ),
          height: attribute == createRoomAttribute.groupName ? 400 : 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (attribute == createRoomAttribute.roomLimit) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                  child: Text(
                    'Pick out the room limit',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
                ...roomLimit.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorPalette.primaryPurple),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 60))),
                          onPressed: () {
                            gameRoomController.createGame.value.roomLimit = e;
                            gameRoomController.createGame.refresh();

                            Navigator.pop(context);
                          },
                          child: Text(
                            e.toString(),
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 16),
                          )),
                    )),
                const SizedBox(
                  height: 16,
                )
              ] else if (attribute == createRoomAttribute.amount) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Select the amount to play',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
                ...amount.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorPalette.primaryPurple),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 60))),
                          onPressed: () {
                            gameRoomController.createGame.value.amount = e;
                            gameRoomController.createGame.refresh();
                            Navigator.pop(context, e);
                          },
                          child: Text(
                            '\$ $e',
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 16),
                          )),
                    )),
                const SizedBox(
                  height: 16,
                )
              ] else if (attribute == createRoomAttribute.commitmentPeriod) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Commitment Period',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
                ...commitmentPeriod.map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorPalette.primaryPurple),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(200, 60))),
                          onPressed: () {
                            gameRoomController
                                .createGame.value.commitmentPeriod = e;
                            gameRoomController.createGame.refresh();
                            Navigator.pop(context);
                          },
                          child: Text(
                            '$e Weeks',
                            style: const TextStyle(
                                color: ColorPalette.snow, fontSize: 16),
                          )),
                    )),
                const SizedBox(
                  height: 16,
                )
              ] else if (attribute == createRoomAttribute.groupName) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Group Name',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: TextFormField(
                    onChanged: (value) {
                      groupname.text = value;
                    },
                    maxLength: 22,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(color: ColorPalette.snow, fontSize: 22),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        counterStyle: TextStyle(color: ColorPalette.snow)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorPalette.primaryPurple),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 50))),
                  onPressed: () {
                    gameRoomController.createGame.value.roomName =
                        groupname.text;
                  gameRoomController.createGame.refresh();
                  Navigator.pop(context);
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(color: ColorPalette.snow, fontSize: 22),
                  ),
                ),
                const SizedBox(),
              ]
            ],
          ),
        ));
  }
}
