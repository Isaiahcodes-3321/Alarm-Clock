import 'widget_export.dart';
import 'package:wheel_picker/wheel_picker.dart';

class PickTime extends StatelessWidget {
  final WheelPickerController hoursWheel;
  final ValueChanged<int> hourIndexChange;
  // minutes
  final WheelPickerController minuteWheel;
  final ValueChanged<int> minuteIndexChange;
  //period
  final WheelPickerController periodWheel;
  final ValueChanged<int> periodIndexChange;

  const PickTime({
    Key? key,
    required this.hoursWheel,
    required this.hourIndexChange,
    required this.minuteWheel,
    required this.minuteIndexChange,
    required this.periodWheel,
    required this.periodIndexChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 26.0, height: 1.5);
    final wheelStyle = WheelPickerStyle(
      size: 200,
      itemExtent: textStyle.fontSize! * textStyle.height!,
      squeeze: 1.2,
      diameterRatio: .9,
      surroundingOpacity: .40,
      magnification: 1.4,
    );
    Widget hourItemBuilder(BuildContext context, int index) {
      int hour = (index + 1) % 12;
      if (hour == 0) hour = 12;
      return pikerTimeText("$hour".padLeft(2, '0'));
    }

    Widget minuteItemBuilder(BuildContext context, int index) {
      return pikerTimeText("${(index + 1)}".padLeft(2, '0'));
    }

    return Consumer(
      builder: (_, WidgetRef ref, __) {
        return SizedBox(
          width: 200.0,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WheelPicker(
                    builder: hourItemBuilder,
                    controller: hoursWheel,
                    looping: true,
                    style: wheelStyle,
                    onIndexChanged: hourIndexChange,
                  ),
                  SizedBox(
                    height: 6.h,
                    child: pikerTimeText(":"),
                  ),
                  WheelPicker(
                      builder: minuteItemBuilder,
                      controller: minuteWheel,
                      style: wheelStyle,
                      enableTap: true,
                      onIndexChanged: minuteIndexChange),
                  WheelPicker(
                      builder: (context, index) {
                        return pikerTimeText(["AM", "PM"][index],
                            fontColor: AppColors.redColor);
                      },
                      controller: periodWheel,
                      looping: false,
                      style: wheelStyle.copyWith(
                        shiftAnimationStyle: const WheelShiftAnimationStyle(
                          duration: Duration(seconds: 1),
                          curve: Curves.bounceOut,
                        ),
                      ),
                      onIndexChanged: periodIndexChange),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Text pikerTimeText(String text, {Color? fontColor}) => Text(
      text,
      style: AppTextStyle.bold(
        fontColor ?? AppColors.whiteColor,
      ),
    );
