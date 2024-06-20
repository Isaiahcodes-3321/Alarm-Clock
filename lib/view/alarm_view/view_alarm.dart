import 'alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'bad_time_wakeup_alarm/bed_time_provider.dart';
import 'package:alarm_clock/view/alarm_view/alarm_controller.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/alarm_list.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bad_time_view.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_listTile.dart';
import 'package:alarm_clock/view/alarm_view/bad_time_wakeup_alarm/bed_time_controls.dart';

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
    callArray();
  }

  // calling the arrays of alarm that user set
  callArray() async {
    await loadItems();
  }

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
                              child:
                                  popMenuText('Set bedtime and wake-up time')),
                        ]),
              ),
              SizedBox(
                height: 4.h,
              ),
              // class to show the listTile that bed time and wake-up time its set
              MaterialButton(
                onPressed: () {
                  RingAlarmControls.checkingTime();
                },
                child: Text(
                  "Click mew",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              // const BedTimeListTile(),
              SizedBox(
                height: 1.h,
              ),
              const AlarmViewList(),
            ],
          ),
        ));
  }
}

Text popMenuText(String text) => Text(
      text,
      style: AppTextStyle.mediumSmall(
        AppColors.whiteColor,
      ),
    );
