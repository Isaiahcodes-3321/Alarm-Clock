import '../alarm_export.dart';
import 'setting_alarm_export.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_export.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';

class SettingAlarmView extends StatefulWidget {
  const SettingAlarmView({super.key});

  @override
  State<SettingAlarmView> createState() => _SettingAlarmViewState();
}

class _SettingAlarmViewState extends State<SettingAlarmView> {
  @override
  void initState() {
    super.initState();
    alarmSelectedHourIndex = alarmHoursWheel.initialIndex;
    alarmSelectedMinuteIndex = alarmMinutesWheel.initialIndex;
    alarmSelectedPeriodIndex = alarmPeriodWheel.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: AnimatedBorderContainer(
          pageName: SizedBox(
            width: 100.w,
            height: 100.h,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    width: 60.w,
                    child: PickTime(
                      hoursWheel: alarmHoursWheel,
                      hourIndexChange: (index) {
                        setState(() {
                          alarmSelectedHourIndex = index;
                          printSelectedHour();
                        });
                      },
                      minuteWheel: alarmMinutesWheel,
                      minuteIndexChange: (index) {
                        setState(() {
                          alarmSelectedMinuteIndex = index;
                          printSelectedMinute();
                        });
                      },
                      periodWheel: alarmPeriodWheel,
                      periodIndexChange: (index) {
                        setState(() {
                          alarmSelectedPeriodIndex = index;
                          printSelectedPeriod();
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                    flex: 6,
                    child: SizedBox(
                        width: 98.5.w,
                        height: 100.h,
                        // color: const Color.fromARGB(255, 92, 244, 54),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.5.h),
                            child: const DatePicking(),
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
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
                SettingAlarmControls.ifDayNotSet();
                },
                child: bottomVavText('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    alarmHoursWheel.dispose();
    alarmMinutesWheel.dispose();
    alarmPeriodWheel.dispose();
    super.dispose();
  }
}

Text bottomVavText(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.blueColor,
      ),
    );
