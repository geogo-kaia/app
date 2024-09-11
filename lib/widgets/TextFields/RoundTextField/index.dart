import 'package:geogo/constants/text_style.dart';
import 'package:geogo/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RoundTextField extends StatelessWidget {
  final bool isObscureText;
  final bool _validate;
  final TextEditingController controller;
  final FocusNode? currentFocus;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  const RoundTextField(this.isObscureText, this.controller, this._validate,
      {this.currentFocus, this.nextFocus, this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: textFieldText,
      obscureText: isObscureText,
      controller: controller,
      autofocus: true,
      keyboardType: inputType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: themeData.backgroundColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(color: themeData.backgroundColor)),
        filled: true,
        fillColor: themeData.cardColor,
        errorText: _validate ? 'Please enter the field' : null,
      ),
      focusNode: currentFocus,
      onEditingComplete: () {
        _fieldFocusChange(context, currentFocus, nextFocus);
      },
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    currentFocus?.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
