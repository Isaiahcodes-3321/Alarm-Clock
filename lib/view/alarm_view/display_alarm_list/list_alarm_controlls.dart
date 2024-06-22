import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:alarm_clock/view/alarm_view/alarm_provider.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_storage.dart';

List<List<String>> items = [];
String alarmList = 'alarmList';
TextEditingController alarmName = TextEditingController();

Future<void> loadItems() async {
  final pref = await StorageBedTime.objPreBedTime();

  // Retrieve the list of encoded lists from SharedPreferences
  List<String> savedItemsEncoded = pref.getStringList(alarmList) ?? [];

  // Decode each list and ensure it has exactly 9 strings
  List<List<String>> savedItems = savedItemsEncoded.map((encodedList) {
    List<String> item = List<String>.from(json.decode(encodedList));
    while (item.length < 10) {
      item.add('');
    }
    return item;
  }).toList();

  items = savedItems;
}

Future<void> saveItems() async {
  final pref = await StorageBedTime.objPreBedTime();

  // Encode each list to a string format suitable for SharedPreferences
  List<String> itemsToSave = items.map((item) => json.encode(item)).toList();

  // Save the list of encoded lists to SharedPreferences
  await pref.setStringList(alarmList, itemsToSave);
}

void addItem() {
  String getHour = "${refProvider.watch(selectedHour)}";
  String getMin = "${refProvider.watch(selectedMin)}";
  String getDaySelectedOnCalender =
      "${refProvider.watch(dateSelectedOnCalender)}";
  bool getIfCalenderItsPicked = refProvider.watch(isCalenderDatePicked);
  print('calender date $getDaySelectedOnCalender');

  if (getIfCalenderItsPicked) {
    items.add([
      '$getHour:$getMin',
      '${refProvider.watch(selectedPeriod)}',
      '',
      '',
      '',
      '',
      '',
      '',
      getDaySelectedOnCalender,
      alarmName.text
    ]);
    print('value its $getIfCalenderItsPicked');
  } else {
    // Add a new list of 9 empty strings to items
    if (refProvider.watch(isM) &&
        refProvider.watch(isT) &&
        refProvider.watch(isW) &&
        refProvider.watch(isThr) &&
        refProvider.watch(isF) &&
        refProvider.watch(isSat) &&
        refProvider.watch(isSun)) {
      refProvider.read(storageAllDaysSelected.notifier).state = 'Every Day';
      items.add([
        '$getHour:$getMin',
        '${refProvider.watch(selectedPeriod)}',
        '',
        '',
        '',
        '',
        '',
        '',
        '${refProvider.watch(storageAllDaysSelected)}',
        alarmName.text
      ]);
    } else {
      items.add([
        '$getHour:$getMin',
        '${refProvider.watch(selectedPeriod)}',
        '${refProvider.watch(monText)}',
        '${refProvider.watch(tueText)}',
        '${refProvider.watch(wedText)}',
        '${refProvider.watch(thrText)}',
        '${refProvider.watch(friText)}',
        '${refProvider.watch(satText)}',
        '${refProvider.watch(sunText)}',
        alarmName.text
      ]);
      refProvider.read(storageAllDaysSelected.notifier).state = '';
    }
  }

  clearVariablesData();
  // items = [];
  saveItems();
}

clearVariablesData() {
  refProvider.read(selectedHour.notifier).state = 0;
  refProvider.read(selectedMin.notifier).state = 0;
  refProvider.read(selectedPeriod.notifier).state = '';
  refProvider.read(monText.notifier).state = '';
  refProvider.read(tueText.notifier).state = '';
  refProvider.read(wedText.notifier).state = '';
  refProvider.read(thrText.notifier).state = '';
  refProvider.read(friText.notifier).state = '';
  refProvider.read(satText.notifier).state = '';
  refProvider.read(sunText.notifier).state = '';
  refProvider.read(isCalenderDatePicked.notifier).state = false;
  alarmName.clear();
}
