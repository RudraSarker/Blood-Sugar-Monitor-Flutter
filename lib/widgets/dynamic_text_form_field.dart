import 'package:blood_sugar_monitor/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
//import 'package:form_field_validator/form_field_validator.dart';

class DynamicFormField extends StatelessWidget {
  final String text;
  final IconData micon;
  final TextInputType inputType;
  final MultiValidator validator;
  final bool obsecureTextChoice;
  final TextEditingController controlerChoice;

  const DynamicFormField({
    Key? key,
    required this.text,
    required this.micon,
    required this.inputType,
    required this.validator,
    this.obsecureTextChoice = false,
    required this.controlerChoice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: controlerChoice,
            obscureText: obsecureTextChoice,
            validator: validator,
            keyboardType: inputType,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                micon,
                color: Colors.white,
              ),
              hintText: 'Enter your $text',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
