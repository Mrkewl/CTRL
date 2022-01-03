import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/gameroomcontroller.dart';
import 'package:ctrl_app/models/creategame_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'attribute_dialog.dart';

enum createRoomAttribute {
  commitmentPeriod,
  amount,
  roomLimit,
  groupName,
  startDate
}

class DropdownTile extends StatelessWidget {
  DropdownTile({
    Key? key,
    required this.title,
    required this.attribute,
    required this.createGamevalues,
  }) : super(key: key);
  final String title;
  final createRoomAttribute attribute;
  final CreateGame createGamevalues;
  final GameRoomController gameRoomController = GameRoomController.to;

  final List<int> commitmentPeriod = [4, 8, 12, 16];
  final List<int> amount = [100, 200, 500];
  final List<int> roomLimit = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: ColorPalette.black,
      ),
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: ColorPalette.snow, fontSize: 24),
              ),
              const Spacer(),
              if (attribute == createRoomAttribute.groupName)
                Text(
                  createGamevalues.roomName ?? 'Not Specified',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 16),
                ),
              if (attribute == createRoomAttribute.commitmentPeriod)
                Text(
                  createGamevalues.commitmentPeriod == null
                      ? 'Not Specified'
                      : '${createGamevalues.commitmentPeriod} Weeks',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 16),
                ),
              if (attribute == createRoomAttribute.amount)
                Text(
                  createGamevalues.amount == null
                      ? 'Not Specified'
                      : '\$ ${createGamevalues.amount}',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 16),
                ),
              if (attribute == createRoomAttribute.roomLimit)
                Text(
                  createGamevalues.roomLimit == null
                      ? 'Not Specified'
                      : '${createGamevalues.roomLimit} Participants',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 16),
                ),
              if (attribute == createRoomAttribute.startDate)
                Text(
                  createGamevalues.startPeriod == null
                      ? 'Not Specified'
                      : 'Start Date: ${DateFormat('dd-MM-yyyy').format(createGamevalues.startPeriod!)}',
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 16),
                ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (attribute == createRoomAttribute.startDate) {
                DateTime? selectedDate;
                selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 7)));
                if (selectedDate != null) {
                  createGamevalues.startPeriod = selectedDate;
                  gameRoomController.createGame.refresh();
                }
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AttributeDialog(
                          createGamevalues: createGamevalues,
                          attribute: attribute,
                          roomLimit: roomLimit,
                          amount: amount,
                          commitmentPeriod: commitmentPeriod,
                        ));
              }
            },
            child: const Icon(Icons.arrow_drop_down_rounded,
                color: ColorPalette.snow, size: 56),
          )
        ],
      ),
    );
  }
}
