import 'setting_alarm_controls.dart';
import 'package:alarm_clock/view/timer/time_export.dart';
import 'package:alarm_clock/view/alarm_view/alarm_export.dart';
import 'package:alarm_clock/view/alarm_view/alarm_controller.dart';
import 'package:alarm_clock/view/alarm_view/display_alarm_list/list_alarm_controlls.dart';



class DatePicking extends StatelessWidget {
  const DatePicking({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    String formattedDate = DateFormat('E, d MMM').format(tomorrow);

    var inputTextStyle = AppTextStyle.medium(
      AppColors.whiteColor,
    );

    return Container(
      width: 100.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: AppColors.lightGreyColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 30, left: 7.w, right: 7.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer(builder: (context, ref, _) {
                    refProvider = ref;
                    return refProvider.watch(isCalenderDatePicked)
                        ? whiteText(refProvider.watch(dateSelectedOnCalender))
                        : refProvider.watch(isAnyDayPick)
                            ? Row(
                                children: [
                                  whiteText(
                                      'Every - ${refProvider.watch(allDaysSelected)}'),
                                  whiteText(refProvider.watch(monText)),
                                  whiteText(refProvider.watch(tueText)),
                                  whiteText(refProvider.watch(wedText)),
                                  whiteText(refProvider.watch(thrText)),
                                  whiteText(refProvider.watch(friText)),
                                  whiteText(refProvider.watch(satText)),
                                  whiteText(refProvider.watch(sunText))
                                ],
                              )
                            : whiteText('Tomorrow - $formattedDate');
                  }),
                  GestureDetector(
                    onTap: () {
                      AlarmControllers.displayDatePiker();
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.whiteColor,
                      size: 25,
                    ),
                  )
                ],
              ),
              const PickDay(),
              SizedBox(
                height: 2.h,
              ),
              TextField(
                controller: alarmName,
                style: inputTextStyle,
                decoration: InputDecoration(
                  hintText: 'Name of Alarm',
                  hintStyle: inputTextStyle,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blueColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blueColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PickDay extends StatelessWidget {
  const PickDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dayCircle('M',
              ref.watch(isM) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isM.notifier).state = !ref.read(isM.notifier).state;
          SettingAlarmControls.isDayPick();
          }),
          dayCircle('T',
              ref.watch(isT) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isT.notifier).state = !ref.read(isT.notifier).state;
          SettingAlarmControls.isDayPick();
          }),
          dayCircle('W',
              ref.watch(isW) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isW.notifier).state = !ref.read(isW.notifier).state;
            SettingAlarmControls.isDayPick();
          }),
          dayCircle(
              'T',
              ref.watch(isThr)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isThr.notifier).state = !ref.read(isThr.notifier).state;
            SettingAlarmControls.isDayPick();
          }),
          dayCircle('F',
              ref.watch(isF) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isF.notifier).state = !ref.read(isF.notifier).state;
            SettingAlarmControls.isDayPick();
          }),
          dayCircle(
              'S',
              ref.watch(isSat)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isSat.notifier).state = !ref.read(isSat.notifier).state;
            SettingAlarmControls.isDayPick();
          }),
          dayCircle(
              'S',
              ref.watch(isSun)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isSun.notifier).state = !ref.read(isSun.notifier).state;
            SettingAlarmControls.isDayPick();
          }),
        ],
      );
    }); 
  }

  Widget dayCircle(String text, Color borderColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 10.w,
        height: 10.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.boldSmall(
              AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

Text whiteText(String text) => Text(
      text,
      style: AppTextStyle.boldMedium(
        AppColors.whiteColor,
      ),
    );
Text blueText(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.blueColor,
      ),
    );
