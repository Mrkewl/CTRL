import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/authenticationcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditMissionTextBox extends StatelessWidget {
  EditMissionTextBox({
    Key? key,
    required this.missionStatement,
  }) : super(key: key);

  final TextEditingController missionStatement;
  final AuthenticationController authenticationController =
      AuthenticationController.to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorPalette.snow.withOpacity(0.17),
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                missionStatement.text = value;
              },
              inputFormatters: [LengthLimitingTextInputFormatter(72)],
              decoration: InputDecoration(
                hintText:
                    authenticationController.missionStatement.value.isEmpty
                        ? 'Investing in my fitness'
                        : authenticationController.missionStatement.value,
                hintStyle: TextStyle(
                    color: ColorPalette.snow.withOpacity(0.50),
                    fontSize: 18,
                    decoration: TextDecoration.none),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                filled: true,
                isDense: true,
              ),
              minLines: 2,
              maxLines: 2,
              keyboardType: TextInputType.visiblePassword,
              // 'Investing in my fitness',
              style: const TextStyle(
                  color: ColorPalette.snow,
                  fontSize: 18,
                  decoration: TextDecoration.none),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Tap to Edit',
                  style: TextStyle(
                      color: ColorPalette.snow.withOpacity(0.50), fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
