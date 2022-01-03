import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({
    Key? key,
    required this.fields,
  }) : super(key: key);
  final RxString fields;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: ColorPalette.black, borderRadius: BorderRadius.circular(25.7)),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          const Text(
            'Gender:',
            style: TextStyle(color: ColorPalette.snow, fontSize: 16),
          ),
          const SizedBox(
            width: 16,
          ),
          DropdownButtonHideUnderline(
            child: Obx(
              () => DropdownButton<String>(
                style: const TextStyle(color: ColorPalette.snow, fontSize: 18),
                dropdownColor: ColorPalette.black,
                iconEnabledColor: ColorPalette.snow,
                value: fields.value,
                onChanged: (value) {
                  fields.value = value!;
                },
                items: <String>[
                  'Male',
                  'Female',
                  'They',
                  'Others',
                  'Undefined',
                  'Nil'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
