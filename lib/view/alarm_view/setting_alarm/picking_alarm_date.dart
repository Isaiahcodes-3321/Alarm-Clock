import 'package:alarm_clock/view/timer/time_export.dart';
import 'package:alarm_clock/view/alarm_view/alarm_export.dart';
import 'package:alarm_clock/view/alarm_view/alarm_controller.dart';

class DatePicking extends StatelessWidget {
  const DatePicking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

    String formattedDate = DateFormat('E, d MMM').format(tomorrow);

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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                whiteText('Tomorrow - $formattedDate'),
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
            const PickDay()
          ],
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
              ref.watch(isM) ? AppColors.blueColor : AppColors.backgroundColor,
              () {
            ref.read(isM.notifier).state = !ref.read(isM.notifier).state;
          }),
          dayCircle('T',
              ref.watch(isT) ? AppColors.blueColor : AppColors.backgroundColor,
              () {
            ref.read(isT.notifier).state = !ref.read(isT.notifier).state;
          }),
          dayCircle('W',
              ref.watch(isW) ? AppColors.blueColor : AppColors.backgroundColor,
              () {
            ref.read(isW.notifier).state = !ref.read(isW.notifier).state;
          }),
          dayCircle(
              'T',
              ref.watch(isThr)
                  ? AppColors.blueColor
                  : AppColors.backgroundColor, () {
            ref.read(isThr.notifier).state = !ref.read(isThr.notifier).state;
          }),
          dayCircle('F',
              ref.watch(isF) ? AppColors.blueColor : AppColors.backgroundColor,
              () {
            ref.read(isF.notifier).state = !ref.read(isF.notifier).state;
          }),
          dayCircle(
              'S',
              ref.watch(isSat)
                  ? AppColors.blueColor
                  : AppColors.backgroundColor, () {
            ref.read(isSat.notifier).state = !ref.read(isSat.notifier).state;
          }),
          dayCircle(
              'S',
              ref.watch(isSun)
                  ? AppColors.blueColor
                  : AppColors.backgroundColor, () {
            ref.read(isSun.notifier).state = !ref.read(isSun.notifier).state;
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

whiteText(String text) => Text(
      text,
      style: AppTextStyle.boldMedium(
        AppColors.whiteColor,
      ),
    );
blueText(String text) => Text(
      text,
      style: AppTextStyle.bold(
        AppColors.blueColor,
      ),
    );
