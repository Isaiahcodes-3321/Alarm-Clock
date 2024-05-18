import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:alarm/widgets/buttons.dart';
import 'package:alarm/themes/app_text.dart';
import 'package:alarm/themes/app_colors.dart';
import 'package:alarm/view/nav_bar/nav_provider.dart';
import 'package:alarm/view/stop_watch/st_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ViewStopWatch extends StatelessWidget {
  const ViewStopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    final StopWatchTimer _stopWatchTimer = StopWatchTimer();

// Stop timer.
    _stopWatchTimer.onStopTimer();
// Reset timer
    _stopWatchTimer.onResetTimer();
// Lap time
    _stopWatchTimer.onAddLap();
    int ht = 3;
    int wth = 100;
    return SafeArea(
      child: Container(
        width: 100.w,
        height: 100.h,
        child: Center(
          child: Column(
            children: [
              Flexible(
                  flex: 8,
                  child: Container(
                    // color: Colors.red,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 6.h,
                        ),
                        Center(
                          child: StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData: 0,
                            builder: (context, snap) {
                              final value = snap.data;
                              final displayTime =
                                  StopWatchTimer.getDisplayTime(value!);
                              return Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: 100.w,
                                    child: Center(
                                      child: Text(
                                        displayTime,
                                        style: AppTextStyle.largeBold(
                                          AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    width: 65.w,
                                    child: Row(
                                      children: [
                                        Flexible(
                                            flex: 3,
                                            child: SizedBox(
                                              width: wth.w,
                                              height: ht.h,
                                              child: hmsTex('Hour'),
                                            )),
                                        Flexible(
                                            flex: 3,
                                            child: SizedBox(
                                              width: wth.w,
                                              height: ht.h,
                                              child: hmsTex('Min'),
                                            )),
                                        Flexible(
                                            flex: 5,
                                            child: SizedBox(
                                              width: wth.w,
                                              height: ht.h,
                                              child: hmsTex('Sec'),
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),

                        // lap time
                        SizedBox(
                          height: 3.h,
                        ),
                        Container(
                          width: 55.w,
                          height: 45.h,
                          // color: Colors.red,
                          child: StreamBuilder<List<StopWatchRecord>>(
                            stream: _stopWatchTimer.records,
                            initialData: const [],
                            builder: (context, snap) {
                              final value = snap.data;
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = value[index];
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          '${index + 1}:   ${data.displayTime}',
                                          style: AppTextStyle.boldMedium(
                                            AppColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                          height: 1,
                                          color:
                                              Color.fromARGB(255, 43, 43, 43))
                                    ],
                                  );
                                },
                                itemCount: value!.length,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: Consumer(builder: (context, ref, _) {
                    refProvider = ref;
                    return Container(
                        // color: Colors.blue,
                        width: 90.w,
                        child: Center(
                            child: ref.watch(isStartButtonClick)
                                ? buttonsRow(
                                    outLineButton(
                                        '  Reset ',
                                        AppColors.blueColor,
                                        AppColors.whiteColor, () {
                                      // Reset timer
                                      _stopWatchTimer.onResetTimer();
                                    }),
                                    // button 2
                                    outLineButton(
                                        '  Start ',
                                        AppColors.blueColor,
                                        AppColors.whiteColor, () {
                                      ref
                                          .read(isStartButtonClick.notifier)
                                          .state = false;
                                      // Start timer
                                      _stopWatchTimer.onStartTimer();
                                    }),
                                  )
                                : buttonsRow(
                                    outLineButton(
                                        '    Lap   ',
                                        AppColors.blueColor,
                                        AppColors.whiteColor, () {
                                      // Lap time
                                      _stopWatchTimer.onAddLap();
                                    }),
                                    // button 2
                                    outLineButton(
                                        '  Stop  ',
                                        AppColors.blueColor,
                                        AppColors.redColor, () {
                                      ref
                                          .read(isStartButtonClick.notifier)
                                          .state = true;
                                      // Stop timer.
                                      _stopWatchTimer.onStopTimer();
                                    }),
                                  )));
                  }))
            ],
          ),
        ),
      ),
    );
  }
}

buttonsRow(Widget button1, button2) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [button1, button2],
    );
// widget to display discription for hour minutes seconds
hmsTex(String text) => Text(
      text,
      style: AppTextStyle.bold(AppColors.blueColor),
    );





