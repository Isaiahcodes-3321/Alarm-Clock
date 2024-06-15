import 'alarm_export.dart';
import 'badtime_wakeup_alarm/bedtime_provider.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bad_time_view.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bed_time_listTile.dart';
import 'package:alarm_clock/view/alarm_view/badtime_wakeup_alarm/bed_time_controls.dart';

class ViewAlarm extends StatefulWidget {
  const ViewAlarm({super.key});

  @override
  State<ViewAlarm> createState() => _ViewAlarmState();
}

class _ViewAlarmState extends State<ViewAlarm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WakeUpTime.ifBedTimeIsTrue();
    print('hey man');
  }

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
                              // to display bottom sheet widget to set alarm volume
                              Scaffold.of(context)
                                  .showBottomSheet((BuildContext context) {
                                return const BottomSheetDisplay();
                              });
                            },
                            child: popMenuText('Alarm Setting')),
                        PopupMenuItem(
                            onTap: () {
                              refProvider.read(isBedTimeM.notifier).state =
                                  false;
                              refProvider.read(isBedTimeT.notifier).state =
                                  false;
                              refProvider.read(isBedTimeW.notifier).state =
                                  false;
                              refProvider.read(isBedTimeThr.notifier).state =
                                  false;
                              refProvider.read(isBedTimeF.notifier).state =
                                  false;
                              refProvider.read(isBedTimeSat.notifier).state =
                                  false;
                              refProvider.read(isBedTimeSun.notifier).state =
                                  false;
                              GetSleepingPeriod.getAllTime();
                              GetSleepingPeriod.getSleepingPeriod();
                              navigateTo(const BadTimeView());
                            },
                            child: popMenuText('Set bedtime and wake-up time')),
                      ]),
            ),
            SizedBox(
              height: 4.h,
            ),
            // class to show the listTile that bed time and wake-up time its set
            const BedTimeListTile(),
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
