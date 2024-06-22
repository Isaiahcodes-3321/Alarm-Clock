import 'package:flutter/material.dart';

durationSeconds(
  int durationTime,
  VoidCallback callBack,
) {
  Future.delayed(Duration(seconds: durationTime), callBack);
}

durationMin(
  int durationTime,
  VoidCallback callBack,
) {
  Future.delayed(Duration(minutes: durationTime), callBack);
}
