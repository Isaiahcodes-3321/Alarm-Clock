import 'package:flutter/material.dart';

// function to make navigation
GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

navigationTo(Widget className) {
  BuildContext context = navigateKey.currentContext!;
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => className,
    ),
  );
}


