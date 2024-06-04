import 'package:alarm_clock/main.dart';
import 'package:flutter/material.dart';

// function to make navigation
navigationTo(Widget className) {
  BuildContext context = navigateKey.currentContext!;
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => className,
    ),
  );
}


