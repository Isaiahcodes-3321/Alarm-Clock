import 'time_export.dart';
import 'package:flutter/material.dart';
import 'package:alarm_clock/widgets/navigation.dart';

class ViewTimer extends StatelessWidget {
  const ViewTimer({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 24;
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: SingleChildScrollView(
        child: Column(
          children: [
            bar(
              '',
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: SizedBox(
                          height: 18.h,
                          child: dialog(),
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
                            onTap: () {
                              Scaffold.of(context)
                                  .showBottomSheet((BuildContext context) {
                                return const BottomSheetDisplay();
                              });
                            },
                            child: popMenuText('Alarm Setting')),
                        PopupMenuItem(
                            onTap: () async {
                              EmptyTimer.emptyTimer();
                            },
                            child: popMenuText('Reset Alarm'))
                      ]),
            ),
            SizedBox(
              height: 3.h,
            ),
            const CountDown()
          ],
        ),
      ),
    );
  }
}

dialog() => Consumer(builder: (context, ref, _) {
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
                  outLineButton(
                      'Cancel', AppColors.lightGreyColor, AppColors.blueColor,
                      () {
                    InputHolder.hourController.clear();
                    InputHolder.minController.clear();
                    InputHolder.secController.clear();
                    Navigator.pop(context);
                  }),
                  outLineButton(
                      ' Set ', AppColors.lightGreyColor, AppColors.blueColor,
                      () async {
                    if (InputHolder.hourController.text.isEmpty) {
                      InputHolder.hourController.text = '00';
                    }
                    if (InputHolder.minController.text.isEmpty) {
                      InputHolder.minController.text = '00';
                    }

                    int convertHr = int.parse(InputHolder.hourController.text);
                    int convertMin = int.parse(InputHolder.minController.text);
                    int convertSec = int.parse(InputHolder.secController.text);

                    final pref = await StorageTimer.objPre();
                    await pref.setInt(StorageTimer.timerKeyHour, convertHr);
                    await pref.setInt(StorageTimer.timerKeyMin, convertMin);
                    await pref.setInt(StorageTimer.timerKeySec, convertSec);

                    final int? hr = pref.getInt(StorageTimer.timerKeyHour);
                    final int? ms = pref.getInt(StorageTimer.timerKeyMin);
                    final int? ss = pref.getInt(StorageTimer.timerKeySec);

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
                    await pref.setString(
                        StorageTimer.featureTimePeriod, period);
                    await pref.setString(StorageTimer.featureTime,
                        '${newHour12.toString().padLeft(2, '0')}:${newMinute.toString().padLeft(2, '0')}');

                    final String? getFeatureTime =
                        pref.getString(StorageTimer.featureTime);
                    final String? getFeatureTimePe =
                        pref.getString(StorageTimer.featureTimePeriod);

                    ref.read(featureTime.notifier).state = getFeatureTime!;
                    ref.read(featureTimePeriod.notifier).state =
                        getFeatureTimePe!;

                    navigateTo(const HomeView());

                    await pref.setBool(StorageTimer.isTimerSet, true);
                    final bool? ifTimerIsSet =
                        pref.getBool(StorageTimer.isTimerSet);
                    ref.read(isTimerSet.notifier).state = ifTimerIsSet!;
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

SizedBox inputBox(Widget widget) => SizedBox(
      width: 15.w,
      height: 6.h,
      child: Padding(
        padding: EdgeInsets.only(top: 2.5.h),
        child: widget,
      ),
    );

Text separator() => Text(
      ':',
      style: AppTextStyle.medium(
        AppColors.blueColor,
      ),
    );

Text popMenuText(String text) => Text(
      text,
      style: AppTextStyle.mediumSmall(
        AppColors.whiteColor,
      ),
    );
