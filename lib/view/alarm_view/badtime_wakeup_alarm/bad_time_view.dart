import 'bedtime_export.dart';
import '../alarm_export.dart';

class BadTimeView extends StatelessWidget {
  const BadTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Container(
                    color: const Color.fromARGB(255, 92, 54, 244),
                    width: 100.w,
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
                child: bottomVavText('Save'),
              )
            ],
          ),
        ),
      ),
    );
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
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft, child: text("Set bed-time")),
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
                    'You will be sleeping in : ${ref.watch(sleepingPeriodHour) == 0 ? '' : '${ref.watch(sleepingPeriodHour)} Hr'} ${ref.watch(sleepingPeriodMin) == 0 ? '' : '${ref.watch(sleepingPeriodMin)} Sec'}'),
              )
           
            ],
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
