import '../alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';
import 'package:alarm_clock/view/alarm_view/setting_alarm/picking_alarm_date.dart';

class SettingAlarmView extends StatelessWidget {
  const SettingAlarmView({super.key});

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
                  width: 60.w,
                  child: const TimePicker(),
                )),
            Flexible(
                flex: 6,
                child: Container(
                    width: 100.w,
                    height: 100.h,
                    // color: const Color.fromARGB(255, 92, 244, 54),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: DatePicking(),
                    )))
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
            children: [
              GestureDetector(
                onTap: () {
                  navigationTo(const HomeView());
                },
                child: bottomVavText('Cancel'),
              ),
              GestureDetector(
                child: bottomVavText('Save'),
              )
            ],
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
  late final periodWheel = WheelPickerController(
    itemCount: 2,
    initialIndex: (now.period == DayPeriod.am) ? 0 : 1,
  );

  int selectedHourIndex = 0;
  int selectedMinuteIndex = 0;
  int selectedPeriodIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedHourIndex = hoursWheel.initialIndex;
    selectedMinuteIndex = minutesWheel.initialIndex;
    selectedPeriodIndex = periodWheel.initialIndex;
  }

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

    void printSelectedHour() {
      final hour = (selectedHourIndex + 1) % 12;
      refProvider.read(selectedHour.notifier).state = hour;
      // print("Selected hour: ${hour == 0 ? 12 : hour}");
    }

    void printSelectedMinute() {
      final minute = selectedMinuteIndex + 1;
      refProvider.read(selectedMin.notifier).state = minute;
      // print("Selected minute: $minute");
    }

    void printSelectedPeriod() {
      final period = selectedPeriodIndex == 0 ? "AM" : "PM";
      refProvider.read(selectedPeriod.notifier).state = period;
      // print("Selected period: $period");
    }

    return Consumer(
      builder: (_, WidgetRef ref, __) {
        refProvider = ref;
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
                    onIndexChanged: (index) {
                      setState(() {
                        selectedHourIndex = index;
                        printSelectedHour();
                      });
                    },
                  ),
                  SizedBox(
                    height: 6.h,
                    child: pikerTimeText(":"),
                  ),
                  WheelPicker(
                    builder: minuteItemBuilder,
                    controller: minutesWheel,
                    style: wheelStyle,
                    enableTap: true,
                    onIndexChanged: (index) {
                      setState(() {
                        selectedMinuteIndex = index;
                        printSelectedMinute();
                      });
                    },
                  ),
                  WheelPicker(
                    builder: (context, index) {
                      return pikerTimeTextPeriod(["AM", "PM"][index]);
                    },
                    controller: periodWheel,
                    looping: false,
                    style: wheelStyle.copyWith(
                      shiftAnimationStyle: const WheelShiftAnimationStyle(
                        duration: Duration(seconds: 1),
                        curve: Curves.bounceOut,
                      ),
                    ),
                    onIndexChanged: (index) {
                      setState(() {
                        selectedPeriodIndex = index;
                        printSelectedPeriod();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    hoursWheel.dispose();
    minutesWheel.dispose();
    periodWheel.dispose();
    super.dispose();
  }
}
