import 'package:flutter/material.dart';

class RoundRectangleBorderTasarimi {
  RoundedRectangleBorder roundedRectangleBorder(BuildContext context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
}
