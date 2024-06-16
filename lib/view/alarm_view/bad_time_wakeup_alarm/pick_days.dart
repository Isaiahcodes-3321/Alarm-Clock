import 'bed_time_export.dart';


class DaysOfBedTime extends StatelessWidget {
  const DaysOfBedTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dayCircle('M',
              ref.watch(isBedTimeM) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isBedTimeM.notifier).state = !ref.read(isBedTimeM.notifier).state;
       
          }),
          dayCircle('T',
              ref.watch(isBedTimeT) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isBedTimeT.notifier).state = !ref.read(isBedTimeT.notifier).state;
     
          }),
          dayCircle('W',
              ref.watch(isBedTimeW) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isBedTimeW.notifier).state = !ref.read(isBedTimeW.notifier).state;
         
          }),
          dayCircle(
              'T',
              ref.watch(isBedTimeThr)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isBedTimeThr.notifier).state = !ref.read(isBedTimeThr.notifier).state;
      
          }),
          dayCircle('F',
              ref.watch(isBedTimeF) ? AppColors.blueColor : AppColors.bottomSheetColor,
              () {
            ref.read(isBedTimeF.notifier).state = !ref.read(isBedTimeF.notifier).state;
        
          }),
          dayCircle(
              'S',
              ref.watch(isBedTimeSat)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isBedTimeSat.notifier).state = !ref.read(isBedTimeSat.notifier).state;
         
          }),
          dayCircle(
              'S',
              ref.watch(isBedTimeSun)
                  ? AppColors.blueColor
                  : AppColors.bottomSheetColor, () {
            ref.read(isBedTimeSun.notifier).state = !ref.read(isBedTimeSun.notifier).state;
          
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