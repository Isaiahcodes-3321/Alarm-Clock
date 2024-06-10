import 'package:intl/intl.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/alarm_view/alarm_export.dart';

class AlarmControllers {
  static DateTime selectedDate = DateTime.now();
  static displayDatePiker() async {
    BuildContext context = navigateKey.currentContext!;
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      DateFormat dateFormat = DateFormat('EEE d MMM');
      String formattedDate = dateFormat.format(selectedDate);
      refProvider.read(isCalenderDatePicked.notifier).state = true;

      refProvider.read(dateSelectedOnCalender.notifier).state = formattedDate;

      print('Selected date: $formattedDate');
    }
  }

 
}


    // String formattedDate =
    //       "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      