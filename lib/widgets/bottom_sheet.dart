import 'widget_export.dart';



class BottomSheetDisplay extends StatefulWidget {
  const BottomSheetDisplay({super.key});

  @override
  State<BottomSheetDisplay> createState() => _BottomSheetDisplayState();
}

class _BottomSheetDisplayState extends State<BottomSheetDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVibrationValue();
    getLoopingValue();
    getVolumeValue();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return Container(
        color: AppColors.bottomSheetColor,
        height: 40.h,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                ListTile(
                  leading: text('Vibrate'),
                  trailing: switchButton(ref.watch(isVibrating), (value) {
                    setState(() {
                      refProvider.read(isVibrating.notifier).state = value;
                      storeVibrateValue();
                    });
                  }),
                ),
                ListTile(
                  leading: text('Loop alarm audio'),
                  trailing: switchButton(ref.watch(isLoopAudio), (value) {
                    setState(() {
                      refProvider.read(isLoopAudio.notifier).state = value;
                      storeLoopingValue();
                    });
                  }),
                ),
                ListTile(
                  leading: text('Alarm Volume'),
                ),
                Slider(
                  activeColor: AppColors.blueColor,
                  inactiveColor: AppColors.whiteColor,
                  value: ref.watch(vibrateVolume),
                  onChanged: (value) {
                    setState(() {
                      refProvider.read(vibrateVolume.notifier).state = value;
                      storeVolumeValue();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

 Text text(String text) => Text(
        text,
        style: AppTextStyle.mediumSmall(
          AppColors.whiteColor,
        ),
      );

  switchButton(bool condition, ValueChanged onChange) => Switch(
        value: condition,
        onChanged: onChange,
        activeTrackColor: AppColors.lightGreyColor,
        activeColor: AppColors.blueColor,
        inactiveThumbColor: AppColors.redColor,
        inactiveTrackColor: AppColors.lightGreyColor,
      );
}

storeVibrateValue() async {
  // get the vibration value from storage and update it on provider
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  final bool? getValue = pref.getBool(AlarmSettingsAudio.vibratingKey);
  if (getValue == null) {
    await pref.setBool(AlarmSettingsAudio.vibratingKey, true);
  } else {
    if (getValue) {
      await pref.setBool(AlarmSettingsAudio.vibratingKey, false);
    } else {
      await pref.setBool(AlarmSettingsAudio.vibratingKey, true);
    }
  }
}

getVibrationValue() async {
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  final bool? getNewValue = pref.getBool(AlarmSettingsAudio.vibratingKey);
  refProvider.read(isVibrating.notifier).state = getNewValue;
}

// function for looping alarm
storeLoopingValue() async {
  // get the looping value from storage and update it on provider
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  final bool? getValue = pref.getBool(AlarmSettingsAudio.loopAudioKey);
  if (getValue == null) {
    await pref.setBool(AlarmSettingsAudio.loopAudioKey, true);
  } else {
    if (getValue) {
      await pref.setBool(AlarmSettingsAudio.loopAudioKey, false);
    } else {
      await pref.setBool(AlarmSettingsAudio.loopAudioKey, true);
    }
  }
}

getLoopingValue() async {
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  final bool? getNewValue = pref.getBool(AlarmSettingsAudio.loopAudioKey);
  refProvider.read(isLoopAudio.notifier).state = getNewValue;
}

// function for Volume alarm
storeVolumeValue() async {
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  await pref.setDouble(
      AlarmSettingsAudio.alarmVolumeKey, refProvider.watch(vibrateVolume));
}

getVolumeValue() async {
  final pref = await AlarmSettingsAudio.alarmSettingsObj();
  final double? getVolumeValue =
      pref.getDouble(AlarmSettingsAudio.alarmVolumeKey);
  refProvider.read(vibrateVolume.notifier).state = getVolumeValue;
}
