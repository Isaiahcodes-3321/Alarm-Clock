import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:wheel_picker/wheel_picker.dart';
import 'package:wheel_picker/wheel_picker.dart';
import 'package:alarm_clock/themes/app_text.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingAlarmView extends StatelessWidget {
  const SettingAlarmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            Flexible(
                flex: 4,
                child: SizedBox(
                  width: 70.w,
                  child: const TimePicker(),
                )),
            Flexible(
                flex: 6,
                child: Container(
                  width: 100.w,
                  height: 100.h,
                  color: const Color.fromARGB(255, 92, 244, 54),
                  child: SingleChildScrollView(),
                ))
          ],
        ),
      )),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColors.backgroundColor,
          height: 9.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [bottomVavText('Cancel'), bottomVavText('Save')],
          ),
        ),
      ),
    );
  }
}

bottomVavText(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.blueColor,
      ),
    );

pikerTimeText(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.whiteColor,
      ),
    );
pikerTimeTextPeriod(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.redColor,
      ),
    );

// picking time

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final now = TimeOfDay.now();
  late final hoursWheel = WheelPickerController(
    itemCount: 12,
    initialIndex: (now.hour % 12) - 1,
  );
  late final minutesWheel = WheelPickerController(
    itemCount: 60,
    initialIndex: now.minute - 1,
    mounts: [hoursWheel],
  );
  

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      size: 200,
      itemExtent: textStyle.fontSize! * textStyle.height!, // Text height
      squeeze: 1.25,
      diameterRatio: .8,
      surroundingOpacity: .25,
      magnification: 1.2,
    );

    Widget hourItemBuilder(BuildContext context, int index) {
      int hour = (index + 1) % 12;
      if (hour == 0) hour = 12;
      return pikerTimeText("$hour".padLeft(2, '0'));
    }

    Widget minuteItemBuilder(BuildContext context, int index) {
      return pikerTimeText("${(index + 1)}".padLeft(2, '0'));
    }

    return SizedBox(
      width: 200.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  WheelPicker(
                    builder: hourItemBuilder,
                    controller: hoursWheel,
                    looping: true,
                    style: wheelStyle,
                  ),
                  pikerTimeText(":"),
                  WheelPicker(
                    builder: minuteItemBuilder,
                    controller: minutesWheel,
                    style: wheelStyle,
                    enableTap: true,
                  )
                ],
              ),
              WheelPicker(
                itemCount: 2,
                builder: (context, index) {
                  return pikerTimeTextPeriod(["AM", "PM"][index]);
                },
                initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
                looping: false,
                style: wheelStyle.copyWith(
                  shiftAnimationStyle: const WheelShiftAnimationStyle(
                    duration: Duration(seconds: 1),
                    curve: Curves.bounceOut,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    hoursWheel.dispose();
    minutesWheel.dispose();
    super.dispose();
  }
}
