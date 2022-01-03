import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateOfBirthTextField extends StatelessWidget {
  const DateOfBirthTextField({
    Key? key,
    required this.fields,
  }) : super(key: key);
  final RxString fields;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? selectedDate;
        selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 80),
            lastDate: DateTime.now());
        if (selectedDate != null) {
          fields.value =
              DateFormat('dd-MM-yyyy').format(selectedDate).toString();
        }
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorPalette.black,
            borderRadius: BorderRadius.circular(25.7)),
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              'Date Of Birth:  ${fields.value}',
              style: const TextStyle(color: ColorPalette.snow, fontSize: 16),
            ),
            const Spacer(),
            const Icon(
              Icons.calendar_today,
              color: ColorPalette.snow,
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
