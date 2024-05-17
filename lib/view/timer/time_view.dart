import 'package:flutter/material.dart';
import 'package:alarm/widgets/bar.dart';
import 'package:alarm/widgets/buttons.dart';
import 'package:alarm/themes/app_text.dart';
import 'package:alarm/themes/app_colors.dart';
import 'package:alarm/widgets/input_field.dart';
import 'package:alarm/view/timer/timer_storage.dart';
import 'package:alarm/view/timer/time_provider.dart';
import 'package:alarm/view/timer/countDown_view.dart';
import 'package:alarm/view/nav_bar/nav_provider.dart';
import 'package:alarm/view/timer/time_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:alarm/view/nav_bar/nav_controls.dart';
// ignore: depend_on_referenced_packages

class ViewTimer extends StatelessWidget {
  ViewTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      double iconSize = 24;
      return Container(
          width: 100.w,
          height: 100.h,
          color: AppColors.backgroundColor,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  bar(
                    GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: SizedBox(
                                height: 18.h,
                                child: Dialog(),
                              ),
                              backgroundColor: AppColors.lightGreyColor,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: iconSize,
                        )),
                    PopupMenuButton(
                        iconSize: iconSize,
                        iconColor: AppColors.whiteColor,
                        color: AppColors.lightGreyColor,
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                  onTap: () {},
                                  child: popMenuText('Alarm Sound')),
                              PopupMenuItem(
                                  onTap: () {
                                    EmptyTimer.emptyTimer();
                                  },
                                  child: popMenuText('Reset Alarm'))
                            ]),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  CountDown()
                ],
              ),
            ),
          ));
    });
  }
}

class Dialog extends StatefulWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return Padding(
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  inputBox(TextInput(
                    hintText: '00',
                    textInput: InputHolder.hourController,
                    onChange: (value) {
                      if (value.length == 2) {
                        FocusScope.of(context).nextFocus();
                        TimerInputControls.ifHourInputEmpty();
                      } else if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        TimerInputControls.ifHourInputEmpty();
                      }
                    },
                  )),
                  separator(),
                  inputBox(TextInput(
                    hintText: '00',
                    textInput: InputHolder.minController,
                    onChange: (value) {
                      if (value.length == 2) {
                        FocusScope.of(context).nextFocus();
                        TimerInputControls.ifMinInputEmpty();
                      } else if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        TimerInputControls.ifMinInputEmpty();
                      }
                    },
                  )),
                  separator(),
                  inputBox(TextInput(
                    hintText: '00',
                    textInput: InputHolder.secController,
                    onChange: (value) {
                      if (value.length == 2) {
                        FocusScope.of(context).nextFocus();
                        TimerInputControls.ifSecInputEmpty();
                      } else if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                        TimerInputControls.ifSecInputEmpty();
                      }
                    },
                  )),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Divider(
                color: AppColors.blueColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  outLineButton('Cancel', () {
                    InputHolder.hourController.clear();
                    InputHolder.minController.clear();
                    InputHolder.secController.clear();
                    Navigator.pop(context);
                  }),
                  outLineButton('Set', () async {
                    if (InputHolder.hourController.text.isEmpty) {
                      InputHolder.hourController.text = '00';
                    }
                    if (InputHolder.minController.text.isEmpty) {
                      InputHolder.minController.text = '00';
                    }

                    int convertHr = int.parse(InputHolder.hourController.text);
                    int convertMin = int.parse(InputHolder.minController.text);
                    int convertSec = int.parse(InputHolder.secController.text);

                    final prefs = await StorageTimer.objPre();
                    await prefs.setInt(StorageTimer.timerKeyHour, convertHr);
                    await prefs.setInt(StorageTimer.timerKeyMin, convertMin);
                    await prefs.setInt(StorageTimer.timerKeySec, convertSec);

                    final int? hr = prefs.getInt(StorageTimer.timerKeyHour);
                    final int? ms = prefs.getInt(StorageTimer.timerKeyMin);
                    final int? ss = prefs.getInt(StorageTimer.timerKeySec);

                    ref.read(intHour.notifier).state = hr!;
                    ref.read(intMin.notifier).state = ms!;
                    ref.read(intSec.notifier).state = ss!;

                    TimeOfDay now = TimeOfDay.now();
                    // Convert current time to minutes
                    int currentTimeInMinutes = now.hour * 60 + now.minute;

                    // Convert user input time to minutes
                    int addedTimeInMinutes = convertHr * 60 + convertMin;

                    int newTimeInMinutes =
                        currentTimeInMinutes + addedTimeInMinutes;

                    // Convert new time back to hours and minutes
                    int newHour24 = (newTimeInMinutes ~/ 60) % 24;
                    int newMinute = newTimeInMinutes % 60;

                    // Convert 24-hour format to 12-hour format
                    int newHour12 = newHour24 % 12 == 0 ? 12 : newHour24 % 12;
                    String period = newHour24 >= 12 ? 'PM' : 'AM';
                    await prefs.setString(
                        StorageTimer.featureTimePeriod, period);
                    await prefs.setString(StorageTimer.featureTime,
                        '${newHour12.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}');

                    final String? getFeatureTime =
                        prefs.getString(StorageTimer.featureTime);
                    final String? getFeatureTimePe =
                        prefs.getString(StorageTimer.featureTimePeriod);

                    ref.read(featureTime.notifier).state = getFeatureTime!;
                    ref.read(featureTimePeriod.notifier).state =
                        getFeatureTimePe!;

                    Navigator.pop(context);
                    InputHolder.hourController.clear();
                    InputHolder.minController.clear();
                    InputHolder.secController.clear();
                  }),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

inputBox(Widget widget) => SizedBox(
      width: 15.w,
      height: 6.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.5.h),
        child: widget,
      ),
    );

separator() => Text(
      ':',
      style: AppTextStyle.medium(
        AppColors.blueColor,
      ),
    );
popMenuText(String text) => Text(
      text,
      style: AppTextStyle.mediumSmall(
        AppColors.whiteColor,
      ),
    );
