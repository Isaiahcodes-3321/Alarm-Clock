import 'package:flutter/material.dart';
import 'package:alarm_clock/themes/app_colors.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:alarm_clock/view/nav_bar/nav_provider.dart';
import 'package:alarm_clock/view/nav_bar/nav_controls.dart';
import 'package:alarm_clock/view/stop_watch/st_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return Scaffold(
        body: Container(
            color: AppColors.backgroundColor,
            child: navViews.elementAt(selectedIndexView)),
        bottomNavigationBar: Container(
          color: AppColors.lightGreyColor,
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(13.sp),
            child: GNav(
              rippleColor: AppColors.blueColor,
              hoverColor: AppColors.blueColor,
              gap: 8,
              activeColor: AppColors.backgroundColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.whiteColor,
              color: AppColors.backgroundColor,
              tabs: [
                GButton(
                  icon: Icons.alarm_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Alarm',
                ),
                GButton(
                  icon: Icons.stop_circle_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Stopwatch',
                ),
                GButton(
                  icon: Icons.timer_off_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Timer',
                ),
              ],
              selectedIndex: selectedIndexView,
              onTabChange: (index) {
                setState(() {
                  selectedIndexView = index;
                  timerSettings();
                  if (selectedIndexView == 0 || selectedIndexView == 2) {
                    ref.read(isStartButtonClick.notifier).state = true;
                    ref.read(isLapButtonClick.notifier).state = false;
                  }
                  // print('num of nave $selectedIndexView');
                });
              },
            ),
          )),
        ),
      );
    });
  }
}
