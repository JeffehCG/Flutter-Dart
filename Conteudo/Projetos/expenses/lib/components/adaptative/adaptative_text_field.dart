import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function onSubmit;
  final TextInputType keyBoardType;

  AdaptativeTextField(
      { this.label, this.controller, this.onSubmit, this.keyBoardType});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CupertinoTextField(
            controller: controller,
            keyboardType: keyBoardType,
            onSubmitted: (_) => onSubmit(),
            placeholder: label,
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12
            ),
          ),
        )
        : TextField(
            // onChanged: (newValue) => value = newValue, //Recuperando dado do formulario
            controller: controller, //Controllando dados do formulario
            keyboardType: keyBoardType, //Tipo do teclado
            decoration: InputDecoration(
              labelText: label,
            ),
            onSubmitted: (_) => onSubmit(),
          );
  }
}
