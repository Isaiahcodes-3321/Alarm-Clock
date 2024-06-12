import 'alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bad_time_view.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bed_time_controls.dart';

class ViewAlarm extends StatelessWidget {
  const ViewAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    double iconSize = 24;
    return SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            bar(
              'Alarm',
              GestureDetector(
                  onTap: () {
                    navigateTo(const SettingAlarmView());
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
                            onTap: () {
                              GetSleepingPeriod.getAllTime();
                              GetSleepingPeriod.getSleepingPeriod();
                              navigateTo(const BadTimeView());
                            },
                            child: popMenuText('Set bedtime and wake-up time')),
                      ]),
            ),
          ],
        ));
  }
}

Text popMenuText(String text) => Text(
      text,
      style: AppTextStyle.mediumSmall(
        AppColors.whiteColor,
      ),
    );
