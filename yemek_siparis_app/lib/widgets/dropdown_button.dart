import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DropDownButtonTasarimi extends StatelessWidget {
  const DropDownButtonTasarimi(
      {required this.onChanged, required this.dropdownValue, super.key});

  final String dropdownValue;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(5),
      value: dropdownValue,
      onChanged: onChanged,
      items: ApplicationConstants.instance!.adet
          .map<DropdownMenuItem<String>>((int value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text("Adet: $value"),
        );
      }).toList(),
    );
  }
}
