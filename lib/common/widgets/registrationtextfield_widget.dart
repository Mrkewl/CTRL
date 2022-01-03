import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/screens/registration/widgets/dateofbirth_textfield.dart';
import 'package:ctrl_app/screens/registration/widgets/gender_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationSignInTextField extends StatelessWidget {
  const RegistrationSignInTextField(
      {Key? key,
      required this.header,
      required this.fields,
      required this.birthday,
      required this.gender})
      : super(key: key);
  final String header;
  final RxString fields;
  final bool birthday;
  final bool gender;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: birthday == true
          ?
          //*Date time box
          DateOfBirthTextField(
              fields: fields,
            )
          : gender == true
              ?
              //*Gender box
              GenderPicker(
                  fields: fields,
                )
              : TextField(
                  onChanged: (input) {
                    fields.value = input;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  style:
                      const TextStyle(color: ColorPalette.snow, fontSize: 18),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorPalette.black),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(25.7),
                        borderSide: const BorderSide(color: ColorPalette.black),
                      ),
                      filled: true,
                      fillColor: ColorPalette.black,
                      isDense: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '$header: ',
                          style: const TextStyle(
                              color: ColorPalette.snow, fontSize: 16),
                        ),
                      ))),
    );
  }
}
