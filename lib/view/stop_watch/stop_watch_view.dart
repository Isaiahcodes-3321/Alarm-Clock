import 'st_export.dart';



class ViewStopWatch extends StatelessWidget {
  const ViewStopWatch({super.key});

  @override
  Widget build(BuildContext context) {
    final StopWatchTimer stopWatchTimer = StopWatchTimer();

    int ht = 3;
    int wth = 100;
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Center(
        child: Column(
          children: [
            Flexible(
                flex: 8,
                child: Column(
                  children: [
                    SizedBox(
                      height: 6.h,
                    ),
                    Center(
                      child: StreamBuilder<int>(
                        stream: stopWatchTimer.rawTime,
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
                              SizedBox(
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
                    SizedBox(
                      width: 35.w,
                      child: Consumer(builder: (context, ref, _) {
                        refProvider = ref;
                        return ref.watch(isLapButtonClick)
                            ? Text(
                                'Lap',
                                style: AppTextStyle.boldMedium(
                                  AppColors.whiteColor,
                                ),
                              )
                            : const Text('');
                      }),
                    ),
                    SizedBox(
                      width: 55.w,
                      height: 45.h,
                      // color: Colors.red,
                      child: StreamBuilder<List<StopWatchRecord>>(
                        stream: stopWatchTimer.records,
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
                                      '${index + 1}:    ${data.displayTime}',
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
                )),
            Flexible(
                flex: 2,
                child: Consumer(builder: (context, ref, _) {
                  refProvider = ref;
                  return SizedBox(
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
                                    stopWatchTimer.onResetTimer();
                                    ref
                                        .read(isLapButtonClick.notifier)
                                        .state = false;
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
                                    stopWatchTimer.onStartTimer();
                                  }),
                                )
                              : buttonsRow(
                                  outLineButton(
                                      '    Lap   ',
                                      AppColors.blueColor,
                                      AppColors.whiteColor, () {
                                    // Lap time
                                    stopWatchTimer.onAddLap();
                                    ref
                                        .read(isLapButtonClick.notifier)
                                        .state = true;
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
                                    stopWatchTimer.onStopTimer();
                                  }),
                                )));
                }))
          ],
        ),
      ),
    );
  }
}

Row buttonsRow(Widget button1, button2) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [button1, button2],
    );
// widget to display description for hour minutes seconds
Text hmsTex(String text) => Text(
      text,
      style: AppTextStyle.bold(AppColors.blueColor),
    );
