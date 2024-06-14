import 'bedtime_export.dart';
import '../alarm_export.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/pick_days.dart';

class BadTimeView extends StatelessWidget {
  const BadTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: AnimatedBorderContainer(
          pageName: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Column(children: [
                const Flexible(
                  flex: 7,
                  child: PickingTime(),
                ),
                Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: 100.w,
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
                        child: const DaysOfBedTime(),
                      ),
                    ))
              ])),
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
                    navigateTo(const HomeView());
                  },
                  child: bottomVavText('Cancel'),
                ),
                GestureDetector(
                  onTap: () {
                    GetSleepingPeriod.getAllTime();
                    SaveBedTime.isBedSetTrue();
                    SaveBedTime.saveInfoBedTime();
                    SaveBedTime.saveInfoWakeTime();
                    navigateTo(const HomeView());
                  },
                  child: bottomVavText('Save'),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class PickingTime extends StatefulWidget {
  const PickingTime({super.key});

  @override
  State<PickingTime> createState() => _PickingTimeState();
}

class _PickingTimeState extends State<PickingTime> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return SizedBox(
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: text("Set bed-time")),
                SizedBox(
                  width: 60.w,
                  height: 20.h,
                  child: PickTime(
                    hoursWheel: BedTimePicker.bedTimeHoursWheel,
                    hourIndexChange: (index) {
                      setState(() {
                        BedTimePicker.bedTimeSelectedHourIndex = index;
                        BedTimePicker.printBedTimeSelectedHour();
                      });
                    },
                    minuteWheel: BedTimePicker.bedTimeMinutesWheel,
                    minuteIndexChange: (index) {
                      setState(() {
                        BedTimePicker.bedTimeSelectedMinuteIndex = index;
                        BedTimePicker.printBedTimeSelectedMinute();
                      });
                    },
                    periodWheel: BedTimePicker.bedTimePeriodWheel,
                    periodIndexChange: (index) {
                      setState(() {
                        BedTimePicker.bedTimeSelectedPeriodIndex = index;
                        BedTimePicker.printBedTimeSelectedPeriod();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: text("Set wake-up time")),
                SizedBox(
                  width: 60.w,
                  height: 20.h,
                  child: PickTime(
                    hoursWheel: WakeUpTimePicker.wakeTimeHoursWheel,
                    hourIndexChange: (index) {
                      setState(() {
                        WakeUpTimePicker.wakeTimeSelectedHourIndex = index;
                        WakeUpTimePicker.printWakeTimeSelectedHour();
                      });
                    },
                    minuteWheel: WakeUpTimePicker.wakeTimeMinutesWheel,
                    minuteIndexChange: (index) {
                      setState(() {
                        WakeUpTimePicker.wakeTimeSelectedMinuteIndex = index;
                        WakeUpTimePicker.printWakeTimeSelectedMinute();
                      });
                    },
                    periodWheel: WakeUpTimePicker.wakeTimePeriodWheel,
                    periodIndexChange: (index) {
                      setState(() {
                        WakeUpTimePicker.wakeTimeSelectedPeriodIndex = index;
                        WakeUpTimePicker.printWakeTimeSelectedPeriod();
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: text(
                      'You will be sleeping in : ${ref.watch(sleepingPeriodHour) == 0 ? '' : '${ref.watch(sleepingPeriodHour)} Hr'} ${ref.watch(sleepingPeriodMin) == 0 ? '' : '${ref.watch(sleepingPeriodMin)} Min'}'),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Text text(String text) => Text(
      text,
      style: AppTextStyle.boldMedium(
        AppColors.whiteColor,
      ),
    );
